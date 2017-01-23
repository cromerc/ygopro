--D - Drag Hammer
function c511009377.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009377.target)
	e1:SetOperation(c511009377.activate)
	c:RegisterEffect(e1)
	
end


function c511009377.filter(c)
	return c:IsFaceup()
end
function c511009377.eqfilter(c)
	return c:IsSetCard(0x8) and c:IsType(TYPE_MONSTER)
end
function c511009377.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c511009377.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c511009377.eqfilter,tp,LOCATION_HAND,0,1,nil) end
		local g=Duel.SelectTarget(tp,c511009377.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
		Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND)
end
function c511009377.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
		local g=Duel.SelectMatchingCard(tp,c511009377.eqfilter,tp,LOCATION_HAND,0,1,1,nil)
		local ec=g:GetFirst()
		if ec then
			Duel.HintSelection(g)
			if not Duel.Equip(tp,ec,tc,true) then return end
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511009377.eqlimit)
			e1:SetLabelObject(tc)
			ec:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(ec:GetTextAttack()*-1)
			ec:RegisterEffect(e2)
			
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e3:SetRange(LOCATION_SZONE)
			e3:SetCode(EVENT_PHASE+PHASE_END)
			e3:SetCountLimit(1)
			e3:SetOperation(c511009377.tgop)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			ec:RegisterEffect(e3)
		end
	end
		
function c511009377.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c511009377.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
