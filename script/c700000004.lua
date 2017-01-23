--Goyo King
function c700000004.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(c700000004.synfilter),1)
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
	e1:SetCondition(c700000004.atkcon)
	e1:SetTarget(c700000004.atktg)
	e1:SetOperation(c700000004.atkop)
	c:RegisterEffect(e1)
	--control all
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700000004,0))
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCondition(aux.bdocon)
	e2:SetTarget(c700000004.cttg)
	e2:SetOperation(c700000004.ctop)
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
	e3:SetCondition(c700000004.ctcon2)
	e3:SetCost(c700000004.ctcost2)
	e3:SetTarget(c700000004.cttg2)
	e3:SetOperation(c700000004.ctop2)
	c:RegisterEffect(e3)
	if not c700000004.global_check then
		c700000004.global_check=true
		c700000004[0]=false
		c700000004[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c700000004.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetOperation(c700000004.clear)
		Duel.RegisterEffect(ge3,0)
	end
end
function c700000004.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(Card.IsControler,1,nil,1-tp) then
		c700000004[tp]=true
	end
	if eg:IsExists(Card.IsControler,1,nil,tp) then
		c700000004[1-tp]=true
	end
end
function c700000004.clear(e,tp,eg,ep,ev,re,r,rp)
	c700000004[0]=false
	c700000004[1]=false
end
function c700000004.synfilter(c)
	return c:IsSetCard(0x204) or c:IsCode(7391448) or c:IsCode(63364266) or c:IsCode(98637386) or c:IsCode(84305651) 
		or c:IsCode(58901502) or c:IsCode(59255742)
end
function c700000004.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	local c=e:GetHandler()
	return ph==PHASE_DAMAGE and (c==Duel.GetAttacker() or c==Duel.GetAttackTarget())
		and not Duel.IsDamageCalculated()
end
function c700000004.atkfilter(c)
	return c:IsFaceup() and c700000004.synfilter(c)
end
function c700000004.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000004.atkfilter,tp,LOCATION_MZONE,0,1,nil) 
		and e:GetHandler():GetFlagEffect(700000004)==0 end
	e:GetHandler():RegisterFlagEffect(700000004,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c700000004.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=Duel.GetMatchingGroupCount(c700000004.atkfilter,tp,LOCATION_MZONE,0,nil)*400
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_BATTLE)
		c:RegisterEffect(e1)
	end
end
function c700000004.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c700000004.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsControlerCanBeChanged() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,nil) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,Card.IsControlerCanBeChanged,tp,0,LOCATION_MZONE,1,ft,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c700000004.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		Duel.GetControl(tc,tp)
		tc=g:GetNext()
	end
end
function c700000004.ctcon2(e,tp,eg,ep,ev,re,r,rp)
	return c700000004[tp]
end
function c700000004.ctcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c700000004.synfilter,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,c700000004.synfilter,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c700000004.ctfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(8) and c:IsAbleToChangeControler()
end
function c700000004.cttg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c700000004.ctfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c700000004.ctfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c700000004.ctfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
end
function c700000004.ctop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.GetControl(tc,tp)
	end
end
