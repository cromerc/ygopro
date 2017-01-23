--Dyna Tank
function c511001648.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,511001649,aux.FilterBoolFunction(Card.IsRace,RACE_DINOSAUR),1,false,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511001648.splimit)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(511001649)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511001648.atkop)
	c:RegisterEffect(e2)
	--switch
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001648,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511001648.tgcon)
	e3:SetOperation(c511001648.tgop)
	c:RegisterEffect(e3)
end
function c511001648.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(511001649)
end
function c511001648.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(ev)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end
function c511001648.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return eg and g:IsContains(c)
end
function c511001648.filter(c,re,rp,tf)
	return tf(re,rp,nil,nil,nil,nil,nil,nil,0,c)
end
function c511001648.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tf=re:GetTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511001648.filter,tp,0,LOCATION_MZONE,1,1,nil,re,rp,tf)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.ChangeTargetCard(ev,g)
	end
end
