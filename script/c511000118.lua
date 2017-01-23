--Diabound Kernel
function c511000118.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000118.eqtg)
	e1:SetOperation(c511000118.eqop)
	c:RegisterEffect(e1)
	--unequip
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000118.uncon)
	e2:SetTarget(c511000118.sptg)
	e2:SetOperation(c511000118.spop)
	c:RegisterEffect(e2)
	--eqlimit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--atk,def
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetCondition(c511000118.uncon)
	e4:SetValue(-1800)
	c:RegisterEffect(e4)
	--spsummon
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000118,0))
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetCondition(c511000118.spcon)
	e5:SetTarget(c511000118.sptg2)
	e5:SetOperation(c511000118.spop2)
	c:RegisterEffect(e5)
	--gain effect
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_BATTLE_DESTROYING)
	e6:SetProperty(EFFECT_FLAG_DELAY)
	e6:SetCondition(aux.bdocon)
	e6:SetTarget(c511000118.efftg)
	e6:SetOperation(c511000118.effop)
	c:RegisterEffect(e6)
end
function c511000118.uncon(e)
	return e:GetHandler():IsStatus(STATUS_UNION)
end
function c511000118.filter(c)
	return c:IsFaceup()
end
function c511000118.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000118.filter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(12309)==0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511000118.filter,tp,0,LOCATION_MZONE,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511000118.filter,tp,0,LOCATION_MZONE,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
	e:GetHandler():RegisterFlagEffect(511000118,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000118.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	if not tc:IsRelateToEffect(e) or not c511000118.filter(tc) then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if not Duel.Equip(tp,c,tc,false) then return end
	c:SetStatus(STATUS_UNION,true)
end
function c511000118.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511000118)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():RegisterFlagEffect(511000118,RESET_EVENT+0x7e0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000118.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c511000118.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	return c:IsReason(REASON_LOST_TARGET) and ec:IsReason(REASON_BATTLE)
end
function c511000118.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000118.spop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
end
function c511000118.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local bc=e:GetHandler():GetBattleTarget()
	Duel.SetTargetCard(bc)
end
function c511000118.effop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
	end
end
