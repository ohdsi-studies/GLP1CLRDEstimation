# Copyright 2021 Observational Health Data Sciences and Informatics
#
# This file is part of HERMESp1bHydra
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Format and check code ---------------------------------------------------
remotes::install_github("ohdsi/OhdsiRTools")
OhdsiRTools::formatRFolder()
OhdsiRTools::checkUsagePackage("HERMESp1bHydra")
OhdsiRTools::updateCopyrightYearFolder()
devtools::spell_check()

# Create manual -----------------------------------------------------------
unlink("extras/HERMESp1bHydra.pdf")
shell("R CMD Rd2pdf ./ --output=extras/HERMESp1bHydra.pdf")

# Create vignettes ---------------------------------------------------------
install.packages("rmarkdown")
dir.create("inst/doc")
rmarkdown::render("vignettes/UsingSkeletonPackage.Rmd",
                  output_file = "../inst/doc/UsingSkeletonPackage.pdf",
                  rmarkdown::pdf_document(latex_engine = "pdflatex",
                                          toc = TRUE,
                                          number_sections = TRUE))
unlink("inst/doc/UsingSkeletonPackage.tex")

rmarkdown::render("vignettes/DataModel.Rmd",
                  output_file = "../inst/doc/DataModel.pdf",
                  rmarkdown::pdf_document(latex_engine = "pdflatex",
                                          toc = TRUE,
                                          number_sections = TRUE))
unlink("inst/doc/DataModel.tex")

# Insert cohort definitions from ATLAS into package -----------------------
remotes::install_github("ohdsi/ROhdsiWebApi")
ROhdsiWebApi::insertCohortDefinitionSetInPackage(fileName = "CohortsToCreate.csv",
                                                 baseUrl = Sys.getenv("baseUrl"),
                                                 insertTableSql = TRUE,
                                                 insertCohortCreationR = TRUE,
                                                 generateStats = FALSE,
                                                 packageName = "HERMESp1bHydra")

# Create analysis details -------------------------------------------------
source("extras/CreateStudyAnalysisDetails.R")
createAnalysesDetails("inst/settings/")
createPositiveControlSynthesisArgs("inst/settings/")

# Store environment in which the study was executed -----------------------
OhdsiRTools::createRenvLockFile("HERMESp1bHydra")
