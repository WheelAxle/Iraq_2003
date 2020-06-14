#include "tracker.as"
#include "helpers.as"
#include "admin_manager.as"
#include "log.as"
#include "query_helpers.as"
#include "query_helpers2.as"

//Author: Unit G17

	// --------------------------------------------
class RepairCrane : Tracker {
	protected Metagame@ m_metagame;

	// --------------------------------------------
	RepairCrane(Metagame@ metagame) {
		@m_metagame = @metagame;
	}

	// --------------------------------------------
	protected void handleEvent(const XmlElement@ event) {
		//repair notify_script key
		string repairKey = "repair";
		
		//checking if the event was triggered by a repair projectile
		string key = event.getStringAttribute("key");		
		if (key == repairKey) {
			//repair effect radius (at 5.0 or higher the crane repairs itself)
			float range = 3.5;
			//the amount of health points added each repair cycle
			float repairValue = 0.6;
			//overrepair percentage
			float overHealth = 1.101;
			
			//xp reward for the repairer each repair cycle
			float xpReward = 0.0002;
			//rp reward for the repairer each repair cycle
			uint rpReward = 3;
			//extracting the repairer's id
			int repairerId = event.getIntAttribute("character_id");
		
			Vector3 repairPos = stringToVector3(event.getStringAttribute("position"));
			repairPos = Vector3(repairPos.get_opIndex(0), repairPos.get_opIndex(1) - 5.0, repairPos.get_opIndex(2));

			//checking for all factions, including neutral
			for (uint f = 0; f < 4; ++f){
				//custom query, collects all vehicles of a faction
				array<const XmlElement@>@ vehicles = getAllVehicles(m_metagame, f);
				
				for (uint i = 0; i < vehicles.length(); ++i) {
					Vector3 vehiclePos = stringToVector3(vehicles[i].getStringAttribute("position"));
					
					if (checkRange(repairPos, vehiclePos, range)) {
						int vehicleId = vehicles[i].getIntAttribute("id");
						const XmlElement@ vehicleInfo = getVehicleInfo(m_metagame, vehicleId);
						string key2 = vehicleInfo.getStringAttribute("key");
						if (key2 != "zjx19.vehicle" &&
							key2 != "repair_crane.vehicle") {
							float vehicleHealth = vehicleInfo.getFloatAttribute("health");
							if (vehicleHealth > 0.0) {
								float vehicleMaxHealth = vehicleInfo.getFloatAttribute("max_health");
								float vehicleMaxOverHealth = vehicleMaxHealth * overHealth;
								
								//only running the update command when necessary
								if (vehicleHealth < vehicleMaxOverHealth) {
									string command = "";
									float vehicleHealthDifference = vehicleMaxOverHealth - vehicleHealth;
									if (vehicleHealthDifference > repairValue){
										vehicleHealth += repairValue;
										vehicleHealthDifference = repairValue;
										command = "<command class='update_vehicle' id='" + vehicleId + "' health='" + vehicleHealth + "' />";
									} else {
										command = "<command class='update_vehicle' id='" + vehicleId + "' health='" + vehicleMaxOverHealth + "' />";
									}
									m_metagame.getComms().send(command);
									
									//rewarding the repairer
									float xpRewardFinal = xpReward * (vehicleHealthDifference / repairValue);
									float rpRewardFinal = rpReward * (vehicleHealthDifference / repairValue);
									command = "<command class='xp_reward' character_id='" + repairerId + "' reward='" + xpRewardFinal + "' />";
									m_metagame.getComms().send(command);
									command = "<command class='rp_reward' character_id='" + repairerId + "' reward='" + rpRewardFinal + "' />";
									m_metagame.getComms().send(command);
								}
							}
						}
					}
				}
			}
		}
    }
}