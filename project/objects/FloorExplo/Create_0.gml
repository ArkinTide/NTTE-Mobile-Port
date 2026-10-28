var _area;

if (!instance_exists(MenuGen) && !instance_exists(Menu)) {
	instance_create(x + orandom(4) + 8, y + random(4) + 8, Debris)
	scrWallBreakSound()
	_area = GameCont.area
}
else {
	_area = area_campfire
}

sprite_index = asset_get_index("sprFloor" + string(_area) + "Explo")

image_speed = 0
image_index = choose(1, 2, 3, 4)

var _list = global.lis_walls_visible

if (!position_meeting(x - 16, y, Floor) && !position_meeting(x - 16, y, Wall)) ds_list_add(_list, instance_create(x - 16, y, Wall))
if (!position_meeting(x + 16, y, Floor) && !position_meeting(x + 16, y, Wall)) ds_list_add(_list, instance_create(x + 16, y, Wall))
if (!position_meeting(x, y + 16, Floor) && !position_meeting(x, y + 16, Wall)) ds_list_add(_list, instance_create(x, y + 16, Wall))
if (!position_meeting(x, y - 16, Floor) && !position_meeting(x, y - 16, Wall)) ds_list_add(_list, instance_create(x, y - 16, Wall))

if (!position_meeting(x - 16, y + 16, Floor) && !position_meeting(x - 16, y + 16, Wall)) ds_list_add(_list, instance_create(x - 16, y + 16, Wall))
if (!position_meeting(x + 16, y - 16, Floor) && !position_meeting(x + 16, y - 16, Wall)) ds_list_add(_list, instance_create(x + 16, y - 16, Wall))
if (!position_meeting(x + 16, y + 16, Floor) && !position_meeting(x + 16, y + 16, Wall)) ds_list_add(_list, instance_create(x + 16, y + 16, Wall))
if (!position_meeting(x - 16, y - 16, Floor) && !position_meeting(x - 16, y - 16, Wall)) ds_list_add(_list, instance_create(x - 16, y - 16, Wall))

scr_screenshake(2)

styleb = 0

material = 2

instance_create(x - 32, y, Top)
instance_create(x, y - 32, Top)
instance_create(x + 32, y, Top)
instance_create(x, y + 32, Top)

instance_create(x - 32, y + 32, Top)
instance_create(x + 32, y - 32, Top)

instance_create(x - 32, y - 32, Top)
instance_create(x + 32, y + 32, Top)

scrTerrainBlastRefreshWalls();
// Original tegeneral.ntte_setup_FloorExplo: remove caps by tile origin,
// including TopTiny reorder copies temporarily using mskNone. A collision
// query alone cannot find those copies and can leave visible wall tops.
with(TopSmall) if(x==other.x && y==other.y) instance_destroy();
scrNTTEFullAreaFloorSetup(_area,true);

// NTTE Coast source terrain origin/filter
area=_area; scrNTTEFullCoastConstructUnwall();
