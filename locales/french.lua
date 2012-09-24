﻿local addon, ns = ...
if ns.Client ~= "frFR" then return end
 -- \n is for add a newline, plese save it when translating. :)
 
ns.L["apply"] = "Utiliser /OMF pour bouger. Recharger l'interface pour appliquer les paramètres."
ns.L["don't have to rl"] = "Ces paramètres deviennent effectif immédiatement"
ns.L["fade"] = "Fondu"
ns.L["enablefade"] = "Activé fondu"
ns.L["enablefade2"] = "Activé le fondu du cadre d'unité lorsque vous n'incantez pas, n'êtes pas en combat, \nn'avez pas de cible et avez le max de vie ou max/min puissance, etc."
ns.L["fadingalpha"] = "Densité du Fondu"
ns.L["fadingalpha2"] = "Visibilité minimum du fondu"
ns.L["font"] = "Font"
ns.L["fontfile"] = "Fichier de police"
ns.L["fontfile2"] = "S'il vous plait fermer le jeu avant d'ajouter/remplacer le fichier xxx.TTF."
ns.L["fontsize"] = "Taille de la police"
ns.L["fontsize2"] = "Taille de la police pour le texte de santé, le texte de la puissance, le nom sur la barre d'incantation, etc"
ns.L["fontflag"] = "Type de police"
ns.L["colormode"] = "Mode couleur"
ns.L["classcolormode"] = "Mode couleur de classe"
ns.L["classcolormode2"] = "activé: couleur de santé basée sur la classe, couleur de puissance basée sur le type de puissance \ndésactivé : couleur de santé basée sur le pourcentage de vie, couleur de puissance basée sur la classe"
ns.L["transparentmode"] = "Mode remplissage inversé"
ns.L["transparentmode2"] = "inverse le remplissage de la barre de santé"
ns.L["onlywhentransparent"] = "Curseur d'opacité n'est disponible que pour le remplissage inversé"
ns.L["startcolor"] = "Couleur dégradée de départ"
ns.L["endcolor"] = "Couleur dégradée de fin"
ns.L["nameclasscolormode"] = "Nom de la couleur de classe"
ns.L["nameclasscolormode2"] = "activé: couleur de classe \ndésactivé: blanc"
ns.L["portrait"] = "Portrait"
ns.L["enableportrait"] = "Afficher le Portrait"
ns.L["portraitalpha"] = " Visiblité Portrait"
ns.L["portraitalpha2"] = "Si vous désactivez le mode de remplissage inversé, \nveuillez réduire la densité du portrait afin que la barre de santé soit plus visible."
ns.L["framesize"] = "Taille du cadre"
ns.L["height"] = "Hauteur du cadre"
ns.L["height2"] = "Hauteur du cadre"
ns.L["width"] = "Largeur du cadre"
ns.L["width2"] = "La largeur pour le cadre du joueur, de la cible et du focus"
ns.L["widthpet"] = "Largeur du cadre familier"
ns.L["widthpet2"] = "La largeur pour le cadre du familier"
ns.L["widthboss"] = "Largeur du cadre Boss"
ns.L["widthboss2"] = "La largeur du cadre du boss"
ns.L["scale"] = "Echelle du cadre"
ns.L["scale2"] = "Echelle du cadre"
ns.L["hpheight"] = "Ratio hauteur barre de santé"
ns.L["hpheight2"] = "Le ratio hauteur de la barre de santé à hauteur du cadre"
ns.L["castbar"] = "Barre d'incantation"
ns.L["enablecastbars"] = "Activé les barres d'incantation"
ns.L["enablecastbars2"] = "Activé toutes les barres d'incantation"
ns.L["cbIconsize"] = "Taille de l'icône de la barre d'incantation"
ns.L["cbIconsize2"] = "Taille de l'icône de la barre d'incantation"
ns.L["aura"] = "Auras"
ns.L["enableauras"] = "Activé les Auras"
ns.L["enableauras2"] = "Activé toutes les auras"
ns.L["auraborders"] = "Bordure des affaiblissements"
ns.L["auraborders2"] = "Colorier la bordure des affaiblissements suivant le type d'affaiblissement."
ns.L["aurasperrow"] = "Aura par ligne"
ns.L["aurasperrow2"] = "Ceci contrôle la taille de l'icône des auras."
ns.L["enableplayerdebuff"] = "Affaiblissement du joueur"
ns.L["enableplayerdebuff2"] = "Afficher les affaiblissements infligés au joueur avant le cadre du joueur"
ns.L["playerdebuffsperrow"] = "Affaiblissement du joueur par ligne"
ns.L["playerdebuffsperrow2"] = "Ceci contrôle la taille de l'icône des auras."
ns.L["AuraFilterignoreBuff"] = "Filtre des Auras : Ignorer les affaiblissements"
ns.L["AuraFilterignoreBuff2"] = "Masquer les améliorations des autres sur les unités amis."
ns.L["AuraFilterignoreDebuff"] = "Filtres des Auras : Ignorer les affaiblissements"
ns.L["AuraFilterignoreDebuff2"] = "Masquer les affaiblissements des autres sur les ennemis."
ns.L["aurafilterinfo"] = "Modifier la liste blanche pour forcer une aura à se montrer quand le filtre est activé.\nSi un affaiblissement est incanté par d'autres sur un ennemi est dans la liste blanche, sa couleur ne sera pas fondue."
ns.L["input spellID"] = "Input spellID"
ns.L["threatbar"] = "Barre de menace"
ns.L["showthreatbar"] = "Activé la barre de menace"
ns.L["showthreatbar2"] = "Affiche une barre de menace de la cible si vous gagnez la menace de celle-ci."
ns.L["tbvergradient"] = "Couleur de dégradé verticale"
ns.L["tbvergradient2"] = "Réglez l'orientation du dégradé de la barre de menace à la verticale"
ns.L["bossframe"] = "Cadre Boss"
ns.L["bossframes"] = "Activé les cadres de Boss"
ns.L["bossframes2"] = "Activé les cadres de Boss"
ns.L["raidshare"] = "Partager les paramètres"
ns.L["enableraid"] = "Activé les cadres de Raid"
ns.L["enableraid2"] = "Activé les cadres de Raid"
ns.L["raidfontsize"] = "Taille de la police du Raid"
ns.L["raidfontsize2"] = "Taille de la police pour les noms de raid, etc"
ns.L["showsolo"] = "Afficher Solo"
ns.L["showsolo2"] = "Afficher le cadre de raid lorsque vous êtes seul"
ns.L["autoswitch"] = "Désactivé Auto Bascule"
ns.L["autoswitch2"] = "Désactivez le pour changer le mode du cadre de raid automatiquement lorsque vous changez votre spécialisation actuelle.\nvous pouvez utiliser /rf pour basculer manuellement."
ns.L["raidonlyhealer"] = "Uniquement Soigneur"
ns.L["raidonlyhealer2"] = "Seulement afficher le mode soigneur pour le cadre de raid.\nCette option est uniquement disponible lorsque l'auto bascule est désactivée."
ns.L["raidonlydps"] = "Uniquement Dps/Tank"
ns.L["raidonlydps2"] = "Seulement afficher le mode Dps/Tank pour le cadre du raid.\nCette option est uniquement disponible lorsque l'auto bascule est désactivée."
ns.L["toggleinfo"] = "Si vous désactivez tout de l'Auto Bascule, Uniquement Soigneur et Uniquement Dps/Tank,\nalors l'addon choisira le cadre de raid correspondant à votre spécialisation à la connexion."
ns.L["enablearrow"] = "Activé la flêche"
ns.L["enablearrow2"] = "Activé la direction de la flêche"
ns.L["arrowsacle"] = "Echelle de la flêche"
ns.L["arrowsacle2"] = "Echelle de la flêche"
ns.L["healerraidtext"] = "Mode Soigneur"
ns.L["groupsize"] = "Taille du groupe"
ns.L["healerraidheight"] = "Hauteur"
ns.L["healerraidheight2"] = "Hauteur pour chaque emplacement d'unité guérisseur de raid."
ns.L["healerraidwidth"] = "Largeur"
ns.L["healerraidwidth2"] = "Largeur pour chaque emplacement d'unité guérisseur de raid."
ns.L["anchor"] = "Ancrage"
ns.L["partyanchor"] = "Ancrage Groupe"
ns.L["showgcd"] = "Barre GCD"
ns.L["showgcd2"] = "Afficher la barre GCD sur le cadre de raid."
ns.L["healprediction"] = "Prédiction Soins"
ns.L["healprediction2"] = "Afficher la barre de prédiction des soins sur le cadre de raid."
ns.L["dpstankraidtext"] = "Mode DPS/Tank"
ns.L["dpsraidheight"] = "Hauteur"
ns.L["dpsraidheight2"] = "Hauteur pour chaque emplacement d'unité dps/tank de raid."
ns.L["dpsraidwidth"] = "Largeur"
ns.L["dpsraidwidth2"] = "Largeur pour chaque emplacement d'unité dps/tank de raid."
ns.L["dpsraidgroupbyclass"] = "Tri par Classe"
ns.L["dpsraidgroupbyclass2"] = "Trier les membres du raid par classe."
ns.L["unitnumperline"] = "Nombre par ligne"
ns.L["unitnumperline2"] = "Combien d'unités voulez-vous afficher par ligne?"
ns.L["add to white list"] = "a été ajouté à la liste blanche du filtre des auras."
ns.L["remove frome white list"] = "a été supprimé à la liste blanche du filtre des auras"
ns.L["not a corret Spell ID"] = "n'est pas un ID de sort correct"