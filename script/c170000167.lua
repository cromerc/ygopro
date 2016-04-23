--Orichalcos Shunoros (Anime)
--By Jackmoonward
function c170000167.initial_effect(c)
	c:EnableReviveLimit()
	--cannot summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--ATK goes down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetCondition(c170000167.statcon)
	e2:SetOperation(c170000167.statop)
	c:RegisterEffect(e2)
	--DEF goes down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c170000167.statcon2)
	e3:SetOperation(c170000167.statop2)
	c:RegisterEffect(e3)
	--DIVINE SERPENT
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetCondition(c170000167.dscon)
	e4:SetTarget(c170000167.dstg)
	e4:SetOperation(c170000167.dsop)
	c:RegisterEffect(e4)
end
function c170000167.statcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local a=Duel.GetAttacker()
local b=Duel.GetAttackTarget()
if c==nil or a==nil or b==nil then return end
if c==a then return b:GetPosition()==POS_FACEUP_ATTACK or b:GetPosition()==POS_FACEDOWN_ATTACK
else if c==b then return a:GetPosition()==POS_FACEUP_ATTACK or a:GetPosition()==POS_FACEDOWN_ATTACK
end
end
end
function c170000167.statop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local atk=bc:GetAttack()
    	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-atk)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e:GetHandler():RegisterEffect(e1)
end
function c170000167.statcon2(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
local a=Duel.GetAttacker()
local b=Duel.GetAttackTarget()
if c==a then return b:GetPosition()==POS_FACEUP_DEFENCE or b:GetPosition()==POS_FACEDOWN_DEFENCE
else if c==b then return a:GetPosition()==POS_FACEUP_DEFENCE or a:GetPosition()==POS_FACEDOWN_DEFENCE
end
end
end
function c170000167.statop2(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local def=bc:GetDefence()
    	local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-def)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        e:GetHandler():RegisterEffect(e1)
end
function c170000167.dscon(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetPreviousAttackOnField()==0 and Duel.GetLP(tp)>=10000 end
end
function c170000167.dstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c170000167.filter(c,e,tp)
	return c:IsCode(170000170) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c170000167.dsop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c170000167.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end