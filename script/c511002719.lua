--Earthbound Servant Geo Gremlin
function c511002719.initial_effect(c)
	aux.AddSynchroProcedure(c,c511002719.sfilter,aux.NonTuner(c511002719.sfilter),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100602,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002719.descon)
	e1:SetTarget(c511002719.destg)
	e1:SetOperation(c511002719.desop)
	c:RegisterEffect(e1)
	if not c511002719.global_check then
		c511002719.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetLabel(511002719)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002719.sfilter(c)
	return c:IsSetCard(0x21f) or c:IsSetCard(0x21) or c:IsCode(67105242) or c:IsCode(67987302)
end
function c511002719.cfilter(tc)
	return tc and tc:IsFaceup()
end
function c511002719.descon(e,tp,eg,ep,ev,re,r,rp)
	return (c511002719.cfilter(Duel.GetFieldCard(tp,LOCATION_SZONE,5)) or c511002719.cfilter(Duel.GetFieldCard(1-tp,LOCATION_SZONE,5))) 
		and Duel.GetCurrentPhase()==PHASE_MAIN1 and e:GetHandler():GetFlagEffect(511002719)~=0
end
function c511002719.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsDestructable() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002719.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if tc:IsFacedown() or Duel.SelectYesNo(1-tp,aux.Stringid(698785,0)) then
			if Duel.Destroy(tc,REASON_EFFECT)>0 then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetCode(EFFECT_SKIP_BP)
				e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
				e1:SetTargetRange(1,0)
				e1:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e1,tp)
			end
		else
			Duel.Recover(tp,tc:GetAttack(),REASON_EFFECT)
		end
	end
end
