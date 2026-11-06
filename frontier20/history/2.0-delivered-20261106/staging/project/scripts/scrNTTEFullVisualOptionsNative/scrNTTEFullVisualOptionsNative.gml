// Source quality_get already interpolates1/3 -> floating physical display scale.
// Preserve the earlier test override, but let absent/undefined use the menu.
function scrNTTEFullVisualQuality(_which) {
    var _scale=scrNTTEFullOptionGet("quality:"+_which)
    if(_which=="minor" && variable_global_exists("ntte_full_minor_quality")
        && is_numeric(global.ntte_full_minor_quality) && global.ntte_full_minor_quality>0)
        _scale=global.ntte_full_minor_quality
    return _scale;
}
