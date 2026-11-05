if(variable_instance_exists(id,"r127_labs") && r127_labs) {
    try {scrRelease127LabNaturalBody();}
    catch(_error) {scrRelease123Capture("R127 LAB FAIL "+string(phase));scrNTTEFullCoastVaultRestore();throw _error;}
} else scrRelease123NaturalStep();
