class_name Profile extends Resource

@export var profile_pic:Texture2D 

@export var name:String
@export var level:int=1
@export var rank:String="Saibaman"
@export var clan:String
var ladderank:int
var wins:int=0
var loses:int=0
var current_streak:int=0

var join_date:Time

var clan_rank:String
var experience:int=0
var highest_streak:int=0
var highest_level:int=0

var user_id:int=0
var email:String
var country:String
var birthday:Time
var gender:String
var website:String

var characters = {
	"Bacterian":1,
	"Jackie Chun":1,
	"Kid Goku":1,
	"Kid Krillin":1,
	"Master Roshi":1,
	"Teen Bulma":1,
	"Yamcha":1,
	"Tien":1,
	"Android 8":1,
	"General Blue":1,
	"Kami":1,
	"Korin":1,
	"Grandpa Gohan":1,
	"See-Through the Invisible Man":1,
	"Bandages the Mummy":1,
	"Fangs":1,	
	"Demon King":1,
	"Teen Goku":1,

}
