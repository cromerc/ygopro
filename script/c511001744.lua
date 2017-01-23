--Goyo King
function c511001744.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(c511001744.synfilter),1)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(3989465,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001744.atkcon)
	e1:SetTarget(c511001744.atktg)
	e1:SetOperation(c511001744.atkop)
	c:RegisterEffect(e1)
	--control all
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001744,0))
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCondition(c511001744.ctcon)
	e2:SetTarget(c511001744.cttg)
	e2:SetOperation(c511001744.ctop)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(4941482,0))
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511001744.ctcon2)
	e3:SetCost(c511001744.ctcost2)
	e3:SetTarget(c511001744.cttg2)
	e3:SetOperation(c511001744.ctop2)
	c:RegisterEffect(e3)
	if not c511001744.global_check then
		c511001744.global_check=true
		c511001744[0]=false
		c511001744[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511001744.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetOperation(c511001744.clear)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511001744.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(Card.IsControler,1,nil,1-tp) then
		c511001744[tp]=true
	end
	if eg:IsExists(Card.IsControler,1,nil,tp) then
		c511001744[1-tp]=true
	end
end
function c511001744.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001744[0]=false
	c511001744[1]=false
end
function c511001744.synfilter(c)
	return c:IsSetCard(0x20f) or c:IsCode(7391448)
end
function c511001744.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	local c=e:GetHandler()
	return ph==PHASE_DAMAGE and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
		and not Duel.IsDamageCalculated()
end
function c511001744.atkfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x20f) or c:IsCode(7391448))
end
function c511001744.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001744.atkfilter,tp,LOCATION_MZONE,0,1,nil) 
		and e:GetHandler():GetFlagEffect(511001744)==0 end
	e:GetHandler():RegisterFlagEffect(511001744,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511001744.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=Duel.GetMatchingGroupCount(c511001744.atkfilter,tp,LOCATION_MZONE,0,nil)*400
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c511001744.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c511001744.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,ft,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c511001744.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		Duel.GetControl(tc,tp)
		tc=g:GetNext()
	end
end
function c511001744.ctcon2(e,tp,eg,ep,ev,re,r,rp)
	return c511001744[tp]
end
function c511001744.costfilter(c)
	return c:IsSetCard(0x20f) or c:IsCode(7391448)
end
function c511001744.ctcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511001744.costfilter,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,c511001744.costfilter,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c511001744.ctfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(8) and c:IsAbleToChangeControler()
end
function c511001744.cttg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001744.ctfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001744.ctfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511001744.ctfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c511001744.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not Duel.GetControl(tc,tp) then
		if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
