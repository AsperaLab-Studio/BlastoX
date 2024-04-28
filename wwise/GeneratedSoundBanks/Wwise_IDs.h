/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Audiokinetic Wwise generated include file. Do not edit.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __WWISE_IDS_H__
#define __WWISE_IDS_H__

#include <AK/SoundEngine/Common/AkTypes.h>

namespace AK
{
    namespace EVENTS
    {
        static const AkUniqueID ASARI_ATTACK = 781605932U;
        static const AkUniqueID ASARI_DEATH = 2365232478U;
        static const AkUniqueID ASARI_HIT = 2677732815U;
        static const AkUniqueID BLASTO_ATTACK = 1343477887U;
        static const AkUniqueID BLASTO_ATTACK_ELECTRIC = 108846699U;
        static const AkUniqueID BLASTO_ATTACK_SHOOT = 3379541511U;
        static const AkUniqueID BLASTO_DEATH = 2170400111U;
        static const AkUniqueID BLASTO_HIT = 2184510782U;
        static const AkUniqueID CREDITS_PLAY_MUSIC = 3022074870U;
        static const AkUniqueID CUTSCENE_PLAY_MUSIC = 2397774794U;
        static const AkUniqueID DESERT_PLAY_BOSS_MUSIC = 2369939213U;
        static const AkUniqueID DESERT_PLAY_MAIN_MUSIC = 2359455101U;
        static const AkUniqueID DESERT_PLAY_MUSIC = 1387614411U;
        static const AkUniqueID GAMEOVER_PLAY_MUSIC = 362522750U;
        static const AkUniqueID JAW_ATTACK = 960940028U;
        static const AkUniqueID JAW_CHARGE_MID = 4202733843U;
        static const AkUniqueID JAW_CHARGE_START = 203922817U;
        static const AkUniqueID JAW_CHARGHE_END = 4175176572U;
        static const AkUniqueID JAW_DEATH = 434562478U;
        static const AkUniqueID JAW_EARTHQUAKE = 2032028959U;
        static const AkUniqueID JAW_HIT = 2816955807U;
        static const AkUniqueID KROGAN_ATTACK = 4128209780U;
        static const AkUniqueID KROGAN_DEATH = 553065750U;
        static const AkUniqueID KROGAN_HIT = 2255747255U;
        static const AkUniqueID MENU_BUTTON_PRESSED = 1048498120U;
        static const AkUniqueID MENU_MOUSE_OVER = 2785341881U;
        static const AkUniqueID MENU_PLAY_MUSIC = 1092296013U;
        static const AkUniqueID NEXT_AREA = 923090826U;
        static const AkUniqueID OCEAN_PLAY_BOSS_MUSIC = 1405004590U;
        static const AkUniqueID OCEAN_PLAY_MAIN_MUSIC = 339355518U;
        static const AkUniqueID OCEAN_PLAY_MUSIC = 509704602U;
        static const AkUniqueID SALARIAN_ATTACK = 405565217U;
        static const AkUniqueID SALARIAN_DEATH = 3201417669U;
        static const AkUniqueID SALARIAN_HIT = 3656616932U;
        static const AkUniqueID TURIAN_ATTACK = 1815802421U;
        static const AkUniqueID TURIAN_DEATH = 440684361U;
        static const AkUniqueID TURIAN_HIT = 1251247560U;
        static const AkUniqueID VINE_DEATH = 4280871310U;
        static const AkUniqueID VINE_HIT = 3793263743U;
        static const AkUniqueID VINE_KNOCKBACK = 2504136357U;
        static const AkUniqueID VINE_PLANT_GROW_DOWN = 3224572430U;
        static const AkUniqueID VINE_PLANT_GROW_UP = 2895845717U;
        static const AkUniqueID VINE_PLANT_SHOOT = 1165879959U;
    } // namespace EVENTS

    namespace STATES
    {
        namespace MUSICPAUSE
        {
            static const AkUniqueID GROUP = 3502235852U;

            namespace STATE
            {
                static const AkUniqueID NONE = 748895195U;
                static const AkUniqueID PAUSE = 3092587493U;
                static const AkUniqueID RESUME = 953277036U;
            } // namespace STATE
        } // namespace MUSICPAUSE

        namespace MUSICTRIGGER
        {
            static const AkUniqueID GROUP = 1927797142U;

            namespace STATE
            {
                static const AkUniqueID COMBAT = 2764240573U;
                static const AkUniqueID DEFEAT = 1593864692U;
                static const AkUniqueID NONE = 748895195U;
                static const AkUniqueID SAFE_ZONE = 2244230815U;
                static const AkUniqueID VICTORY = 2716678721U;
            } // namespace STATE
        } // namespace MUSICTRIGGER

    } // namespace STATES

    namespace GAME_PARAMETERS
    {
        static const AkUniqueID MUSIC_SLIDER = 1127857866U;
        static const AkUniqueID SFX_SLIDER = 4140634290U;
    } // namespace GAME_PARAMETERS

    namespace BANKS
    {
        static const AkUniqueID INIT = 1355168291U;
        static const AkUniqueID MAIN = 3161908922U;
    } // namespace BANKS

    namespace BUSSES
    {
        static const AkUniqueID ATTACKS = 3768541028U;
        static const AkUniqueID AUTO_DUCKING = 2276611188U;
        static const AkUniqueID DEATH = 779278001U;
        static const AkUniqueID GAMEPLAY = 89505537U;
        static const AkUniqueID HIT = 1116398592U;
        static const AkUniqueID JAW_CHARGE = 2264234380U;
        static const AkUniqueID JAW_EARTHQUAKE = 2032028959U;
        static const AkUniqueID MASTER_AUDIO_BUS = 3803692087U;
        static const AkUniqueID MUSIC = 3991942870U;
        static const AkUniqueID NEXT_AREA = 923090826U;
        static const AkUniqueID SFX = 393239870U;
    } // namespace BUSSES

    namespace AUX_BUSSES
    {
        static const AkUniqueID GAMEPLAY_REVERB = 1396213152U;
        static const AkUniqueID MENU_REVERB = 3420137967U;
    } // namespace AUX_BUSSES

    namespace AUDIO_DEVICES
    {
        static const AkUniqueID NO_OUTPUT = 2317455096U;
        static const AkUniqueID SYSTEM = 3859886410U;
    } // namespace AUDIO_DEVICES

}// namespace AK

#endif // __WWISE_IDS_H__
