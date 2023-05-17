local Translations = {
	info = {
		header = "Informations",
		blipsinfo = "Repères visuels",
		lightninginfo = "Éclairage",
		amountbasket = "Paniers souhaités",
		amountchoose = "Montant souhaité",
		basketharvested = "Paniers récoltés",
		returninfo = "Retourner",
		rebirth = "Rebirth",
		rebirthinfo = "Vous avez rebirth",
		amount = "Montant:"
	},
	xp = {
		currentxp = "XP: %{currentxpmore}",
		currentxprebirth = "XP: %{currentxpmore} | Rebirth: %{currentrebirth}"
	},
	targets = {
		activity = "Activité",
		harvest = "Récolter",
		transformation = "Transformation",
		sell = "Vente",
		entersellingzone = "Entrer"
	},
	activity = {
		header = "Activité",
		headerstarted = "Activité en cours..",
		finishharvest = "Vous avez terminé la récolte",
		cancelactivity = "Annuler l'activité",
		canceledactivity = "Vous avez annulé l'activité",
		finishactivity = "Terminer l'activité",
		finishedactivity = "Vous avez terminé l'activité",
		progressiondrawtext = "Progression:",
		activityfinisheddrawtext = "Activité terminée"
	},
	transformation = {
		header = "Transformation",
		cost = "Pré-requis:",
		progressbar = "Transformation en cours.."
	},
	sell = {
		header = "Revente",
		addtobasket = "Ajouter au panier",
		removetobasket = "Retirer du panier",
		itemsheader = "Items",
		basketheader = "Paniers",
		nothinginbasket = "Vous avez rien dans votre panier",
		noitemtoaddtobasket = "Vous avez aucun item à ajouter dans votre panier",
		beginselling = "Débuter la revente",
		storevehicledrawtext = "[E] - Ranger le véhicule"
	},
	error = {
		vehicleinarea = "Il y a un véhicule dans les alentours",
		inventorytofull = "Votre inventaire est plein..",
		notenoughitems = "Il vous manque un certain item..",
		deathevent = "Annulation de l'activité dû à votre mort"
	}
}

Lang = Locale:new({
  phrases = Translations,
  warnOnMissing = true
})