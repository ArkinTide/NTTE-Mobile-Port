// The source repeatedly nests a Swarmer-name filter and a commander filter.
// Iterate the same native enemy family in the same order, retaining missing
// fields and native equality, without constructing/unioning whole-enemy lists.
// This is deliberately not cached: recruiting, death and commander changes
// must be visible to the very next source query in the same logical tick.
function scrFRSwarmbotMatching(_field,_expected) {
    var _found=[];
    with(enemy) {
        if(variable_instance_exists(id,"name") && name=="Swarmer") {
            var _value=undefined;
            if(variable_instance_exists(id,_field)) _value=variable_instance_get(id,_field);
            if(_value==_expected) array_push(_found,real(id));
        }
    }
    return _found;
}
