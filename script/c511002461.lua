--Jam Breeding Machine 
--scripted by GameMaster (GM)
function c511002461.initial_effect(c)
--Activate
local e1=Effect.CreateEffect(c)
e1:SetType(EFFECT_TYPE_ACTIVATE)
e1:SetCode(EVENT_FREE_CHAIN)
c:RegisterEffect(e1)
--token
local e2=Effect.CreateEffect(c)
e2:SetDescription(aux.Stringid(110,0))
e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
e2:SetRange(LOCATION_SZONE)
e2:SetCountLimit(1)
e2:SetCondition(c511002461.spcon)
e2:SetTarget(c511002461.sptg)
e2:SetOperation(c511002461.spop)
c:RegisterEffect(e2)
local e3=Effect.CreateEffect(c)
e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
e3:SetRange(LOCATION_SZONE)
e3:SetCode(EVENT_SUMMON_SUCCESS)
e3:SetCondition(c511002461.descon)
e3:SetOperation(c511002461.desop)
c:RegisterEffect(e3)
local e4=e3:Clone()
e4:SetCode(EVENT_SPSUMMON_SUCCESS)
c:RegisterEffect(e4)
local e5=e3:Clone()
e5:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
c:RegisterEffect(e5)
end

c511002461.collection={ [31709826]=true; [46821314]=true; [3918345]=true; 
[26905245]=true; [511001208]=true;[511001205]=true; [37984162]=true; 
[511000482]=true; [511001207]=true; [100000706]=true;[511001206]=true; 
[511000285]=true; [5600127]=true; [45206713]=true; [72291412]=true; 
[21770261]=true; }

function c511002461.spcon(e,tp,eg,ep,ev,re,r,rp)
return Duel.GetTurnPlayer()==tp
end
function c511002461.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511002461.spop(e,tp,eg,ep,ev,re,r,rp)
if not e:GetHandler():IsRelateToEffect(e) then return end
if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
and Duel.IsPlayerCanSpecialSummonMonster(tp,21770261,0,0x4011,500,500,1,RACE_AQUA,ATTRIBUTE_WATER) then
local token=Duel.CreateToken(tp,21770261)
Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
end
function c511002461.filter1(c,tp)
return c:IsFaceup() and c:GetSummonPlayer()==tp and not c511002461.collection[c:GetCode()]
end
function c511002461.descon(e,tp,eg,ep,ev,re,r,rp)
return eg:IsExists(c511002461.filter1,1,nil,tp)
end
function c511002461.desop(e,tp,eg,ep,ev,re,r,rp)
Duel.Destroy(e:GetHandler(),REASON_RULE)
end
