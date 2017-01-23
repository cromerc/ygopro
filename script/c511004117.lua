--Vaccination
--scripted by:urielkama
function c511004117.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511004117.target)
	e1:SetOperation(c511004117.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--immune effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c511004117.stimtg)
	e3:SetValue(c511004117.stimfilter)
	c:RegisterEffect(e3)
	--equip to another target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetDescription(aux.Stringid(511004117,0))
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c511004117.retcon)
	e4:SetTarget(c511004117.rettg)
	e4:SetOperation(c511004117.retop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)	
end
function c511004117.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end
function c511004117.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511004117.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511004117.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511004117.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511004117.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsLocation(LOCATION_SZONE) then return end
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		Duel.BreakEffect()
		tc:AddCounter(0x1108,1)
		end	
end
function c511004117.stimfilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER+TYPE_EFFECT) and c511004117.collection[te:GetCode()]
end
function c511004117.stimtg(e,c)
	return c:IsType(TYPE_MONSTER) and c:GetCounter(0x1108)>0
end
function c511004117.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE or bit.band(tc:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
		and tc:GetMaterialCount()>0
end
function c511004117.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
    local c=e:GetHandler()
    local ec=c:GetPreviousEquipTarget()
	local tc=eg:GetFirst()
	local g=tc:GetMaterial()
	if chkc then return g:IsContains(chkc) and chkc:IsCanBeEffectTarget(e) end
	if chk==0 then return g:IsExists(Card.IsCanBeEffectTarget,1,nil,e) end
	if g:GetCount()>1 and g==ec then
		g=g:FilterSelect(tp,Card.IsCanBeEffectTarget,1,1,nil,e)
	end
	Duel.SetTargetCard(g)
	tc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,c,1,0,0)
end
function c511004117.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sc=eg:GetFirst()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and (tc:IsReason(REASON_RELEASE) or tc:IsReason(REASON_FUSION)) and sc and sc:IsRelateToEffect(e) and sc:IsFaceup() and c and c:IsRelateToEffect(e) then
		Duel.Equip(tp,c,sc)
		Duel.BreakEffect()
		sc:AddCounter(0x1108,1)
		Duel.ConfirmCards(tc:GetPreviousControler(),tc)
	end
end
c511004117.collection={
[86361354]=true;[33184167]=true;[24725825]=true;
[22804644]=true;[170000150]=true;[511000398]=true;
[35027493]=true;[39163598]=true;[54591086]=true;
[57728570]=true;[84491298]=true;[100000166]=true;
[511000822]=true;[511000823]=true;[511002576]=true;
}