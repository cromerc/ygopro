--Ｔｈｅ アトモスフィア
function c511002293.initial_effect(c)
	--summon with 3 tribute
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(78651105,1))
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SUMMON_PROC)
	e3:SetCondition(c511002293.ttcon)
	e3:SetOperation(c511002293.ttop)
	e3:SetValue(SUMMON_TYPE_ADVANCE+1)
	c:RegisterEffect(e3)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(95100269,0))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002293.eqcon)
	e2:SetTarget(c511002293.eqtg)
	e2:SetOperation(c511002293.eqop)
	c:RegisterEffect(e2)
end
function c511002293.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=3
end
function c511002293.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g, REASON_SUMMON+REASON_MATERIAL)
end
function c511002293.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetLabelObject()
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+1
end
function c511002293.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511002293.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511002293.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local atk=tc:GetTextAttack()
			local def=tc:GetTextDefense()
			if atk<0 or tc:IsFacedown() then atk=0 end
			if def<0 or tc:IsFacedown() then def=0 end
			if not Duel.Equip(tp,tc,c,false) then return end
			e:SetLabelObject(tc)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511002293.eqlimit)
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
			if def>0 then
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_EQUIP)
				e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
				e3:SetCode(EFFECT_UPDATE_DEFENSE)
				e3:SetReset(RESET_EVENT+0x1fe0000)
				e3:SetValue(def)
				tc:RegisterEffect(e3)
			end
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
