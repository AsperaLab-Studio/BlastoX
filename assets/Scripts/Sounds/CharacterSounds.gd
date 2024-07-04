extends Node2D


# Blasto

func AttackMeleeSound01():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_ATTACK_01, self.get_parent())

func AttackMeleeSound02():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_ATTACK_02, self.get_parent())

func AttackMeleeSound03():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_ATTACK_03, self.get_parent())

func AttackElectricSound():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_ATTACK_ELECTRIC, self.get_parent())

func AttackShootSound():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_ATTACK_SHOOT, self.get_parent())

func DeathSound():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_DEATH, self.get_parent())

func HitSound():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_HIT, self.get_parent())

func JumpSound():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.BLASTO_JUMP, self.get_parent())


# Enemies

func AsariAttack():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.ASARI_ATTACK, self.get_parent())

func AsariHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.ASARI_HIT, self.get_parent())

func AsariDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.ASARI_DEATH, self.get_parent())

func KroganAttack():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.KROGAN_ATTACK, self.get_parent())

func KroganHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.KROGAN_HIT, self.get_parent())

func KroganDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.KROGAN_DEATH, self.get_parent())

func SalarianAttack():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.SALARIAN_ATTACK, self.get_parent())

func SalarianHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.SALARIAN_HIT, self.get_parent())

func SalarianDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.SALARIAN_DEATH, self.get_parent())

func TurianAttack():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.TURIAN_ATTACK, self.get_parent())

func TurianHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.TURIAN_HIT, self.get_parent())

func TurianDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.TURIAN_DEATH, self.get_parent())


# Bosses

# - The Jaw
func JawDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_DEATH, self.get_parent())

func JawHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_HIT, self.get_parent())

func JawAttack():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_ATTACK, self.get_parent())

func JawQuake():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_EARTHQUAKE, self.get_parent())

func JawChargeStart():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_CHARGE_START, self.get_parent())

func JawChargeMid():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_CHARGE_MID, self.get_parent())

func JawChargeEnd():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.JAW_CHARGHE_END, self.get_parent())

# -- The Vine
func VineDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.VINE_DEATH, self.get_parent())

func VineHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.VINE_HIT, self.get_parent())

func VineSpear():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.VINE_PLANT_GROW_UP, self.get_parent())

func VineGun():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.VINE_PLANT_GROW_DOWN, self.get_parent())

func VineShoot():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.VINE_PLANT_SHOOT, self.get_parent())

func VinePush():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.VINE_KNOCKBACK, self.get_parent())

# --- The Gun
func GunDeath():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.GUN_DEATH, self.get_parent())

func GunHit():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.GUN_HIT, self.get_parent())

func GunRifle():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.GUN_RIFLE, self.get_parent())

func GunRocket():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.GUN_ROCKET, self.get_parent())

func GunGranade():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.GUN_GRANADE, self.get_parent())

func GunExplosion():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.GUN_EXPLOSION, self.get_parent())

# ---- The Legs
func LegLand():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_LAND, self.get_parent())

func LegJump():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_JUMP, self.get_parent())

func LegSprint():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_SPRINT, self.get_parent())

func LegAttack():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_ATTACK, self.get_parent())

func Leg01Death():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_01_DEATH, self.get_parent())

func Leg01Pain():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_01_PAIN, self.get_parent())

func Leg02Death():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_02_DEATH, self.get_parent())

func Leg02Pain():
	Wwise.register_game_obj(self.get_parent(), self.get_parent().name)
	Wwise.post_event_id(AK.EVENTS.LEG_02_PAIN, self.get_parent())
