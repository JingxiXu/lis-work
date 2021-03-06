; Do not have disjuntion (or) functionality for actions yet. 
; Cannot create if.. then.. for preconditions by using or (.. and ..)

(define (domain kitchen)
  (:requirements :strips :equality)
  (:predicates (isGripper ?x)
               (isSpoon ?x)
               (isMeat ?x)
               (isVeg ?x)
               (isSpatula ?x)
               (isWok ?x)
               (isSalt ?x)
               (isOil ?x)
               (onTable ?x)
               (isGraspable ?x)
               (isScoopable ?x)
               (gripperEmpty)
               (wokEmpty)
               (spoonEmpty)
               (gripperHolding ?x)
               (meatCooked)
               (vegCooked) 
               (saltAdded)
               (oilAdded)
               (meatAdded)
               (vegAdded)
               (inSpoon ?x)
               (inWok ?x))

  (:action pickup
    :parameters (?ob)
    :precondition (and (onTable ?ob) 
                       (gripperEmpty) 
                       (isGraspable ?ob))
    :effect (and (gripperHolding ?ob) 
                 (not (onTable ?ob))
                 (not (gripperEmpty))))

  (:action drop-spoon
    :parameters (?ob)
    :precondition (and (gripperHolding ?ob)
                       (isSpoon ?ob)
                       (spoonEmpty)
                       (not (onTable ?ob)))
    :effect (and (gripperEmpty)
                 (not (gripperHolding ?ob))
                 (onTable ?ob)))

  (:action drop-spatula
    :parameters (?ob)
    :precondition (and (gripperHolding ?ob)
                       (isSpatula ?ob)
                       (not (onTable ?ob)))
    :effect (and (gripperEmpty)
                 (not (gripperHolding ?ob))
                 (onTable ?ob)))
                 
  (:action add-oil
    :parameters (?ob ?wok)
    :precondition (and (isWok ?wok)
                       (isOil ?ob)
                       (inSpoon ?ob)
                       (wokEmpty)
                       (onTable ?wok))
    :effect (and (oilAdded)
                 (not (inSpoon ?ob))
                 (not (wokEmpty))
                 (inWok ?ob)
                 (spoonEmpty)))

  (:action add-meat
    :parameters (?ob ?wok)
    :precondition (and (isWok ?wok)
                       (isMeat ?ob)
                       (gripperHolding ?ob)
                       (oilAdded))
    :effect (and (meatAdded)
                 (not (gripperHolding ?ob))
                 (gripperEmpty)
                 (inWok ?ob)
                 ))

  (:action add-veg
    :parameters (?ob ?wok)
    :precondition (and (isWok ?wok)
                       (isVeg ?ob)
                       (gripperHolding ?ob)
                       (oilAdded)
                       (meatCooked))
    :effect (and (vegAdded)
                 (not (gripperHolding ?ob))
                 (gripperEmpty)
                 (inWok ?ob)
                 ))

  (:action add-salt
    :parameters (?ob ?wok)
    :precondition (and (isWok ?wok)
                       (isSalt ?ob)
                       (inSpoon ?ob)
                       (meatCooked)
                       (vegCooked))
    :effect (and (saltAdded)
                 (not (inSpoon ?ob))
                 (inWok ?ob)
                 (spoonEmpty)
                 ))

  (:action scoop
    :parameters (?ob ?spoon)
    :precondition (and (isSpoon ?spoon)
                       (isScoopable ?ob)
                       (gripperHolding ?spoon)
                       (spoonEmpty)
                       (onTable ?ob))
    :effect (and (inSpoon ?ob)
                 (not (spoonEmpty))
                 ))

  (:action fry-meat
    :parameters (?ob ?spatula)
    :precondition (and (isSpatula ?spatula)
                       (inWok ?ob)
                       (gripperHolding ?spatula)
                       (oilAdded)
                       (isMeat ?ob))
    :effect (meatCooked))

  (:action fry-veg
    :parameters (?ob ?spatula)
    :precondition (and (isSpatula ?spatula)
                       (inWok ?ob) ; equally, vegAdded
                       (gripperHolding ?spatula)
                       (oilAdded)
                       (isVeg ?ob)
                       (meatCooked))
    :effect (vegCooked)))

