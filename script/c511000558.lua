--Life Stream Dragon
function c511000558.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure2(c,nil,aux.FilterBoolFunction(Card.IsCode,2403771))
	c:EnableReviveLimit()
	--change lp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000558,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511000558.lpcon)
	e1:SetOperation(c511000558.lpop)
	c:RegisterEffect(e1)
	--damage reduce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(c511000558.damval)
	c:RegisterEffect(e2)
	--lvchange
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000558,3))
	e3:SetCategory(CATEGORY_LVCHANGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c511000558.lvtg)
	e3:SetOperation(c511000558.lvop)
	c:RegisterEffect(e3)
end
function c511000558.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_SYNCHRO and (Duel.GetLP(tp)<4000 or Duel.GetLP(1-tp)<4000)
end
function c511000558.lpop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)<4000 and Duel.SelectYesNo(tp,aux.Stringid(511000558,1)) then
		Duel.BreakEffect()
		Duel.SetLP(tp,4000)
	end
	if Duel.GetLP(1-tp)<4000 and Duel.SelectYesNo(tp,aux.Stringid(511000558,2)) then
		Duel.BreakEffect()
		Duel.SetLP(1-tp,4000)
	end
end
function c511000558.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0 end
	return val
end
function c511000558.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000558.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000558.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
end
function c511000558.lvop(e,tp,eg,ep,ev,re,r,rp)
	local lv=Duel.AnnounceNumber(tp,1,2,3,4,5,6,7,8,9,10,11,12)
	local g=Duel.GetMatchingGroup(c511000558.filter,tp,LOCATION_MZONE,0,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
