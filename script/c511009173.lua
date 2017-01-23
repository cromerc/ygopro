--Wind Witch Winter Bell
function c511009173.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xf0),aux.NonTuner(Card.IsSetCard,0xf0),1)
	c:EnableReviveLimit()
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41209827,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009173.nmtg)
	e2:SetOperation(c511009173.nmop)
	c:RegisterEffect(e2)
	if not c511009173.global_check then
		c511009173.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(511009173)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(511009173)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511009173.nmfil(c)
	return c:IsLevelBelow(4) and c:IsSetCard(0xf0) and c:IsType(TYPE_MONSTER)
end
function c511009173.nmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511009173.nmfil(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009173.nmfil,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009173.nmfil,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c511009173.nmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
	end
end
