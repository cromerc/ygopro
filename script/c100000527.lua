--運命の戦車
function c100000527.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000527,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c100000527.eqtg)
	e1:SetOperation(c100000527.eqop)
	c:RegisterEffect(e1)
	--unequip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000527,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000527.uncon)
	e2:SetTarget(c100000527.sptg)
	e2:SetOperation(c100000527.spop)
	c:RegisterEffect(e2)
	--direct_attack
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(100000527,2))
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c100000527.uncon)
	e5:SetCost(c100000527.atkcost)
	e5:SetOperation(c100000527.atkop)
	c:RegisterEffect(e5)
	--destroy sub
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_EQUIP)
	e6:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e6:SetCode(EFFECT_DESTROY_SUBSTITUTE)
	e6:SetCondition(c100000527.uncon)
	e6:SetValue(c100000527.repval)
	c:RegisterEffect(e6)
	--eqlimit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_EQUIP_LIMIT)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetValue(c100000527.eqlimit)
	c:RegisterEffect(e7)
end
function c100000527.uncon(e)
	return e:GetHandler():IsStatus(STATUS_UNION)
end
function c100000527.repval(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c100000527.eqlimit(e,c)
	return c:GetCode()==100000533 or c:GetCode()==100000534 or c:GetCode()==100000537 or c:GetCode()==100000538 
end
function c100000527.filter(c)
	return c:IsFaceup() and (c:GetCode()==100000533 or c:GetCode()==100000534 or c:GetCode()==100000537 or c:GetCode()==100000538) and c:GetUnionCount()==0
end
function c100000527.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000527.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(100000527)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c100000527.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c100000527.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(100000527,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000527.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not tc:IsRelateToEffect(e) or not c100000527.filter(tc) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc,false) then return end
	c:SetStatus(STATUS_UNION,true)
end
function c100000527.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(100000527)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(100000527,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000527.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_ATTACK)
	end
end
function c100000527.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetValue(c100000527.value)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e2)		
end
function c100000527.value(e,c)
	return c:GetAttack()/2
end
function c100000527.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e3)
end
