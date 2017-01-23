--スーパービークロイド－ステルス・ユニオン
function c511002959.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode4(c,61538782,98049038,71218746,984114,true,true)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3897065,0))
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511002959.eqtg)
	e1:SetOperation(c511002959.eqop)
	c:RegisterEffect(e1)
	--attack all
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetCondition(c511002959.atcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetOperation(c511002959.atkop)
	c:RegisterEffect(e4)
end
function c511002959.eqfilter(c,tp)
	return c:IsFaceup() and not c:IsRace(RACE_MACHINE) and (c:IsControler(tp) or c:IsAbleToChangeControler())
end
function c511002959.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511002959.eqfilter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511002959.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511002959.eqfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,e:GetHandler(),tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511002959.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511002959.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsType(TYPE_MONSTER) and not tc:IsRace(RACE_MACHINE) and tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			if not Duel.Equip(tp,tc,c,false) then return end
			--equip limit
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511002959.eqlimit)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(511002959)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
function c511002959.atcon(e)
	return e:GetHandler():IsHasEffect(511002959)
end
function c511002959.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsHasEffect(511002959) and c:GetAttackedCount()>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e1:SetValue(c:GetBaseAttack()/2)
		c:RegisterEffect(e1)
	end
end
