#include "map/utils/moduleutils.h"

#include "common/logging.h"
#include "common/sql.h"
#include "map/lua/luautils.h"
#include "map/packets/char_stats.h"
#include "map/packets/chat_message.h"
#include "map/utils/charutils.h"

class FlipModule : public CPPModule
{
    void OnInit() override
    {
        lua["CBaseEntity"]["flip"] = [](CLuaBaseEntity* PLuaBaseEntity, int32 arg)
        {
            TracyZoneScoped;

            CBaseEntity* PEntity = PLuaBaseEntity->GetBaseEntity();
            if (PEntity->objtype != TYPE_PC)
            {
                return;
            }

            auto* PChar = static_cast<CCharEntity*>(PEntity);

            // PChar and arg are available from here onwards
            {
                bool lv99 = false;


                if (arg == 99)
                {
                    lv99 = true;
                }

                uint8 flipstate = (uint8)charutils::GetCharVar(PChar, "JobFlipState");


                if (lv99 == true)
                {
                    if (flipstate == 0) // 99 Flip
                    {
                    flipstate = 4; // lets flip to 99
                    PChar->pushPacket(new CChatMessagePacket(PChar, MESSAGE_SYSTEM_3, "Fake 99 ON", "Server"));
                    }

                    else if (flipstate == 4) // 99 Flip
                    {
                    flipstate = 0; // lets unflip to 99
                    PChar->pushPacket(new CChatMessagePacket(PChar, MESSAGE_SYSTEM_3, "Fake 99 OFF", "Server"));
                    }
            }

                charutils::SetCharVar(PChar, "JobFlipState", flipstate);
                PChar->pushPacket(new CCharStatsPacket(PChar, false));

                return;
            }
        };
    }
};

REGISTER_CPP_MODULE(FlipModule);