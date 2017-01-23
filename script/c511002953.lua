--Wind Witch - Winter Bell
function c511002953.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xf0),aux.NonTuner(Card.IsSetCard,0xf0),1)
	c:EnableReviveLimit()
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30312361,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511002953.target)
	e1:SetOperation(c511002953.operation)
	c:RegisterEffect(e1)
	if not c511002953.global_check then
		c511002953.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(511002953)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(511002953)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002953.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xf0) and c:IsLevelBelow(4)
end
function c511002953.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511002953.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002953.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002953.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c511002953.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
		c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
	end
end
