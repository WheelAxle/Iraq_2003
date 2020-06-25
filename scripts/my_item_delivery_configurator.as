#include "item_delivery_configurator_invasion.as"

// ------------------------------------------------------------------------------------------------
class MyItemDeliveryConfigurator : ItemDeliveryConfiguratorInvasion {
	// ------------------------------------------------------------------------------------------------
	MyItemDeliveryConfigurator(GameModeInvasion@ metagame) {
		super(metagame);
	}

	// --------------------------------------------
	array<Resource@>@ getUnlockWeaponList() const {
		array<Resource@> list;

		// --------------------------------------------
		// TODO:
		// - replace these with suitable items for briefcase delivery rewards
		// --------------------------------------------

		list.push_back(Resource("an94.weapon", "weapon"));
		list.push_back(Resource("rgm40.weapon", "weapon"));
		list.push_back(Resource("sg552.weapon", "weapon"));
		list.push_back(Resource("m79.weapon", "weapon"));
		list.push_back(Resource("minig_resource.weapon", "weapon"));
		list.push_back(Resource("desert_eagle.weapon", "weapon"));
		list.push_back(Resource("tow_resource.weapon", "weapon"));
   		list.push_back(Resource("eodvest.carry_item", "carry_item"));   
         
		return list;
	}

	// --------------------------------------------
	array<Resource@>@ getUnlockWeaponList2() const {
		array<Resource@> list;

		// --------------------------------------------
		// TODO:
		// - replace these with suitable items for laptop delivery rewards
		// --------------------------------------------

		list.push_back(Resource("mp5sd.weapon", "weapon"));
		list.push_back(Resource("asval.weapon", "weapon"));
		list.push_back(Resource("sks_supp.weapon", "weapon"));
		list.push_back(MultiGroupResource("vest_blackops.carry_item", "carry_item", array<string> = {"default", "supply"}));
		list.push_back(Resource("m40a3_supp.weapon", "weapon")); 
		list.push_back(Resource("dragunov_svd_supp.weapon", "weapon")); 
		list.push_back(Resource("mosin_supp.weapon", "weapon")); 
		list.push_back(Resource("vss_vintorez.weapon", "weapon));       
         
		return list;
	}
	
	// --------------------------------------------
	array<Resource@>@ getDeliverablesList() const {
		array<Resource@> list;

		// --------------------------------------------
		// TODO:
		// - replace these with what we want to track as delivered to armory, with intention of unlocking that same item
		// --------------------------------------------

		// green weapons
		list.push_back(Resource("m16a2.weapon", "weapon"));
		list.push_back(Resource("m240.weapon", "weapon"));
		list.push_back(Resource("m40a3.weapon", "weapon"));
		list.push_back(Resource("mossberg.weapon", "weapon"));
		list.push_back(Resource("m72_law.weapon", "weapon"));

		// grey weapons
		list.push_back(Resource("ak47.weapon", "weapon"));
		list.push_back(Resource("mg42.weapon", "weapon"));
		list.push_back(Resource("mosin.weapon", "weapon"));
		list.push_back(Resource("ppsh.weapon", "weapon"));
		list.push_back(Resource("rpg-7", "weapon"));

		// brown weapons
		list.push_back(Resource("akm.weapon", "weapon"));
		list.push_back(Resource("pkm.weapon", "weapon"));
		list.push_back(Resource("dragunov_svd.weapon", "weapon"));
		list.push_back(Resource("asval.weapon", "weapon"));
		list.push_back(Resource("rpg-18.weapon", "weapon"));

		return list;
	}

	// --------------------------------------------
	// NOTE:
	// also see vanilla\scripts\gamemodes\invasion\item_delivery_configurator_invasion.as:
	// protected void setupGift1()
	// protected void setupGift2()
	// protected void setupGift3()

}
