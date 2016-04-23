--Scripted by Eerie Code
--Frightfur March
function c6668.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetCondition(c6668.negcon)
	e1:SetTarget(c6668.negtg)
	e1:SetOperation(c6668.negop)
	c:RegisterEffect(e1)
end

function c6668.negfil(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0xad)
end
function c6668.negcon(e,tp,eg,ep,ev,re,r,rp)
	return rp~=tp and eg:IsExists(c6668.negfil,1,nil,tp) and Duel.IsChainDisablable(ev)
end
function c6668.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,re:GetHandler(),1,0,0)
	end
end
function c6668.spfil(c,e,tp)
	return c:IsSetCard(0xad) and c:IsLevelAbove(8) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false)
end
function c6668.spcfil(c)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0xad) and c:IsAbleToGraveAsCost()
end
function c6668.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) and Duel.Destroy(re:GetHandler(),REASON_EFFECT)~=0 then
		local cg=Group.Filter(eg,c6668.spcfil,nil)
		local sg=Duel.GetMatchingGroup(c6668.spfil,tp,LOCATION_EXTRA,0,nil,e,tp)
		if sg:GetCount()>0 and cg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(6668,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local cost=cg:Select(tp,1,1,nil)
			if Duel.SendtoGrave(cost,REASON_COST)~=0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local dg=sg:Select(tp,1,1,nil)
				if dg then
					local tc=dg:GetFirst()
					Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
					tc:RegisterFlagEffect(6668,RESET_EVENT+0x1fe0000,0,1)
					local de=Effect.CreateEffect(e:GetHandler())
					de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
					de:SetCode(EVENT_PHASE+PHASE_END)
					de:SetCountLimit(1)
					de:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
					de:SetLabelObject(tc)
					de:SetCondition(c6668.descon)
					de:SetOperation(c6668.desop)
					if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_END then
						de:SetLabel(Duel.GetTurnCount())
						de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
					else
						de:SetLabel(0)
						de:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
					end
					Duel.RegisterEffect(de,tp)
				end
			end
		end
	end
end
function c6668.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel() and tc:GetFlagEffect(6668)~=0
end
function c6668.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end