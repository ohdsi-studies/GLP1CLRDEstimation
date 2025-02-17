remotes::install_github("OHDSI/Hydra@develop")

library(Hydra)

specs <- Hydra::loadSpecifications("C:/Users/admin_mconove1/Documents/GLP1Repro/GLP1CLRDEstimation/GLP1ReproExac/specs.json")
hydrate(specifications=specs,
        outputFolder = "C:/Users/admin_mconove1/Documents/GLP1Repro/GLP1CLRDEstimation/GLP1ReproExac/HydratedPackage",
        packageName = "HERMESp2Hydra")
