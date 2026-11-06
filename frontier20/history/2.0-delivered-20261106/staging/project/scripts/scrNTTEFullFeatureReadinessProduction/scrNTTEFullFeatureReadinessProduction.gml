// Release certificate list. Saved ownership never grants implementation readiness.
// Preserve valid maps exactly: desktop closed-gate fixtures and native re-entry
// may intentionally hold explicit false values. No merging or inferred keys.
function scrNTTEFullFeatureReadinessInit() {
    if(variable_global_exists("ntte_full_feature_ready") && is_struct(global.ntte_full_feature_ready)) return false
    var _ready={}
    variable_struct_set(_ready,"skill:compassion",true)
    variable_struct_set(_ready,"race:beetle",true)
    variable_struct_set(_ready,"race:parrot",true)
    variable_struct_set(_ready,"skin:angler fish",true)
    variable_struct_set(_ready,"skin:bat eyes",true)
    variable_struct_set(_ready,"skin:bonus robot",true)
    variable_struct_set(_ready,"skin:coat venuz",true)
    variable_struct_set(_ready,"skin:cool frog",true)
    variable_struct_set(_ready,"skin:orchid plant",true)
    variable_struct_set(_ready,"skin:red crystal",true)
    variable_struct_set(_ready,"crown:crime",true)
    variable_struct_set(_ready,"crown:red",true)
    variable_struct_set(_ready,"bonus",true)
    variable_struct_set(_ready,"crown:bonus",true)
    global.ntte_full_feature_ready=_ready
    return true
}
