--ZS - Ouroboros Sage
function c511000993.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000993,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511000993.sptg)
	e1:SetOperation(c511000993.spop)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000993,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511000993.eqtg)
	e2:SetOperation(c511000993.eqop)
	c:RegisterEffect(e2)
end
function c511000993.filter(c,e,tp)
	return c:IsSetCard(0x48) and c:GetAttribute()~=ATTRIBUTE_LIGHT and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000993.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511000993.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and
		Duel.IsExistingTarget(c511000993.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000993.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000993.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc:RegisterFlagEffect(511000993,RESET_EVENT+0x1fe0000,0,0)
	end
	Duel.SpecialSummonComplete()
end
function c511000993.eqfilter(c)
	return c:GetFlagEffect(511000993)>0
end
function c511000993.ufilter(c)
	return c:IsFaceup() and (c:IsCode(65305468) or c:IsSetCard(0x7f))
end
function c511000993.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000993.eqfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>1
		and Duel.IsExistingTarget(c511000993.eqfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) 
		and Duel.IsExistingMatchingCard(c511000993.ufilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511000993.eqfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511000993.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511000993.ufilter,tp,LOCATION_MZONE,0,1,1,nil)
	local eq=g:GetFirst()
	if not eq then return end
	if not c:IsRelateToEffect(e) then return end
	if (c:IsLocation(LOCATION_MZONE) and c:IsFacedown()) or (eq:IsLocation(LOCATION_MZONE) and eq:IsFacedown()) then return end
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=1 or tc:GetControler()~=tp or tc:IsFacedown() or not tc:IsRelateToEffect(e) then
		g:AddCard(c)
		Duel.SendtoGrave(g,REASON_EFFECT)
		return
	end
	Duel.Equip(tp,c,tc,true)
	Duel.Equip(tp,eq,tc,true)
	local atk1=c:GetTextAttack()
	local atk2=eq:GetTextAttack()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetLabelObject(tc)
	e1:SetValue(c511000993.eqlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(atk1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e3:SetLabelObject(tc)
	e3:SetValue(c511000993.eqlimit)
	eq:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetValue(atk2)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	eq:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000993,2))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511000993.atkcon)
	e5:SetOperation(c511000993.atkop)
	e5:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e5)
end
function c511000993.eqlimit(e,c)
	return e:GetLabelObject()==c
end
function c511000993.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler():GetEquipTarget()
end
function c511000993.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=c:GetEquipTarget()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	e1:SetValue(eq:GetAttack()*2)
	eq:RegisterEffect(e1)
end
