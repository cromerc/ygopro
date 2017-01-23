--Monster Clock
function c511009139.initial_effect(c)
--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(61538782,1))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	
	e1:SetCondition(c511009139.eqcon)
	e1:SetTarget(c511009139.eqtg)
	e1:SetOperation(c511009139.eqop)
	c:RegisterEffect(e1)
end

function c511009139.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	if c:IsFacedown() then return false end
	e:SetLabelObject(tc)
	return tc:IsLocation(LOCATION_MZONE) and tc:IsType(TYPE_MONSTER)
end
function c511009139.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=e:GetLabelObject()
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,tc,1,0,0)
end
function c511009139.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=tc:GetTextAttack()
		if atk<0 then atk=0 end
		if not Duel.Equip(tp,tc,c,false) then return end
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511009139.eqlimit)
		tc:RegisterEffect(e1)
		if atk>0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(atk)
			tc:RegisterEffect(e2)
		end
	end
end
function c511009139.eqlimit(e,c)
	return e:GetOwner()==c
end