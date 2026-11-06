ntte_full_portal_timer=0
type = 1
image_speed = (0.4) * timescale
endgame = 100

snd_play(GameCont.underwater ? sndOasisPortal : sndPortalOpen)

if instance_exists(Player) {
    with projectile {
        if (team != team_player) instance_destroy(id, 0)
	}
}

instance_create(x, y, PortalClear)
instance_create(x, y, PortalShock)

with (Player) {
	if (race != Race.Rogue) continue
	repeat (2) instance_create(other.x, other.y, IDPDSpawn)
    GameCont.popolevel -= 1.5
}

repeat (4) scrFX(x, y, PortalL, random_angle, 3)

close = false

attract_objects = function(_object_index, _attract_distance) {
	var _px = x, _py = y, _half = _attract_distance * 0.5;
	
	with (_object_index) {
		var _is_player = instance_is(self, Player),
			_distance = point_distance(x, y, _px, _py)
		
        if (_distance <= _attract_distance && !collision_line(x, y, _px, _py, Wall, 0, 0)) {
			// 60帧适配：这是「每步」的吸引位移。
			// 注意本函数虽写在 Create 事件里，却由 Step_0.gml 每帧调用，
			// 因此工具按文件判定时不会处理它，必须手工乘 timescale。
			var _spd = ((_distance > _half) ? 2 : 5) * timescale,
				_direction = point_direction(x, y, _px, _py),
				_tx = x + ldrx(_spd, _direction),
				_ty = y + ldry(_spd, _direction)
			
			if (place_free(_tx, y)) x = _tx
			if (place_free(x, _ty)) y = _ty
			
			if (_is_player && _distance <= _half) {
				angle -= (30 * right) * timescale
		        sprite_index = spr_hurt
		        image_index = 1
			}
			else if (object_index == WepPickup) {
				mp_potential_step_object(_px, _py, (1) * timescale, Wall)
				image_angle -= (15 * rotspeed) * timescale
			}
        }
		
		if (_is_player && _distance > _half && !roll && angle != 0) {
			angle = 0
		}
	}
}
// NTTE Coast original Portal constructor
scrNTTEFullCoastConstructPortal();
// BEGIN NTTE SEWER PIZZA TEST PROBE Portal.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Portal.Create.after");
// END NTTE SEWER PIZZA TEST PROBE Portal.Create.after

// BEGIN NTTE OASIS TRENCH READONLY PROBE Portal.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id)
    && instance_exists(NTTEFullOasisTrenchNaturalEntryTest))
    scrNTTEFullOasisTrenchEntryProbe("Portal.Create.after");
// END NTTE OASIS TRENCH READONLY PROBE Portal.Create.after
// BEGIN NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchConnectedCampaignTest) && instance_exists(id)) try { scrNTTEFullTrenchCampaignProbe("Portal.Create.after"); }
catch(_ntte_trench_campaign_error) { scrNTTEFullTrenchCampaignAbort(_ntte_trench_campaign_error); }
// END NTTE TRENCH CONNECTED CAMPAIGN TEST Portal.Create.after
// BEGIN NTTE TRENCH SECOND HOP TEST Portal.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullTrenchSecondHopConnectedTest) && instance_exists(id)) try { scrNTTEFullTrenchSecondHopProbe("Portal.Create.after"); }
catch(_ntte_trench_second_hop_error) { scrNTTEFullTrenchSecondHopAbort(_ntte_trench_second_hop_error); }
// END NTTE TRENCH SECOND HOP TEST Portal.Create.after
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Portal.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("Portal.Create.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Portal.Create.after