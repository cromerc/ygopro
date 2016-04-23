--Scripted by Eerie Code
--Goyo King
function c700000004.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(c700000004.synfil),1)
	c:EnableReviveLimit()
	--ATK Up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_BATTLE_PHASE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c700000004.atkcon)
	e1:SetCost(c700000004.atkcost)
	e1:SetOperation(c700000004.atkop)
	c:RegisterEffect(e1)
	--Control post-battle
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c700000004.ctrtg1)
	e2:SetOperation(c700000004.ctrop1)
	c:RegisterEffect(e2)
	--Control with Tribute
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c700000004.ctrcon2)
	e3:SetCost(c700000004.ctrcost2)
	e3:SetTarget(c700000004.ctrtg2)
	e3:SetOperation(c700000004.ctrop2)
	c:RegisterEffect(e3)
end

function c700000004.synfil(c)
	return c:IsSetCard(0x512) or c:IsCode(7391448) or c:IsCode(63364266) or c:IsCode(98637386) or c:IsCode(6844)
end

function c700000004.gcfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)
end
function c700000004.gccon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c700000004.gcfilter,1,nil,tp)
end

function c700000004.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=Duel.GetAttacker()
	if bt and bt==c then return not c:IsStatus(STATUS_CHAINING) end
	bt=Duel.GetAttackTarget()
	return bt and bt==c and not c:IsStatus(STATUS_CHAINING)
end
function c700000004.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(700000004)==0 end
	e:GetHandler():RegisterFlagEffect(700000004,RESET_PHASE+RESET_DAMAGE_CAL,0,1)
end
function c700000004.atkfil(c)
	return c:IsFaceup() and (c:IsSetCard(0x512) or c:IsCode(7391448) or c:IsCode(63364266) or c:IsCode(98637386) or c:IsCode(6844))
end
function c700000004.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(400*Duel.GetMatchingGroupCount(c700000004.atkfil,tp,LOCATION_MZONE,0,nil))
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	c:RegisterEffect(e1)
end

function c700000004.ctrfil1(c)
	return c:IsFaceup() and c:IsAbleToChangeControler()
end
function c700000004.ctrtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700000004.ctrfil1(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c700000004.ctrfil1,tp,0,LOCATION_MZONE,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c700000004.ctrfil1,tp,0,LOCATION_MZONE,1,ft,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c700000004.ctrop1(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=tg:GetFirst()
	while tc do
		Duel.GetControl(tc,tp)
		tc=tg:GetNext()
	end
end

function c700000004.ctrcon2(e,tp,eg,ep,ev,re,r,rp)
	--return e:GetHandler():GetFlagEffect(700000005)>0
	return Duel.GetActivityCount(1-tp,ACTIVITY_NORMALSUMMON)>0 or Duel.GetActivityCount(1-tp,ACTIVITY_SPSUMMON)>0
end
function c700000004.ctrcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c700000004.atkfil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c700000004.atkfil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c700000004.ctrfil2(c)
	return c:IsFaceup() and c:IsAbleToChangeControler() and c:IsLevelBelow(8)
end
function c700000004.ctrtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700000004.ctrfil2(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c700000004.ctrfil2,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c700000004.ctrfil2,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c700000004.ctrop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	Duel.GetControl(tc,tp)
end