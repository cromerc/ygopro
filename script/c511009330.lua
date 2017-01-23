--Gathering Light
function c511009330.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attach
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCost(c511009330.spcost)
	e2:SetTarget(c511009330.sptg)
	e2:SetOperation(c511009330.spop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c511009330.tg)
	e3:SetValue(c511009330.val)
	c:RegisterEffect(e3)
	--negate attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e4:SetCountLimit(1)
	e4:SetCondition(c511009330.condition)
	e4:SetOperation(c511009330.operation)
	c:RegisterEffect(e4)
end
function c511009330.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c511009330.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009330.costfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511009330.costfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511009330.filter(c,e,tp)
	return (c:IsRace(RACE_DRAGON) or c511009330.collection[c:GetCode()] or c:IsSetCard(0x1045) or c:IsSetCard(0x1093)) 
end
c511009330.collection={
	[86240887]=true;[86805855]=true;[70681994]=true;[511000705]=true;[1546123]=true;
	[64599569]=true;[84243274]=true;[91998119]=true;[74157028]=true;[87751584]=true;
	[40418351]=true;[79229522]=true;[2111707]=true;[25119460]=true;[9293977]=true;
	[84058253]=true;[72959823]=true;[100000570]=true;[100000029]=true;[100000621]=true;
	[54752875]=true;[86164529]=true;[21435914]=true;[6021033]=true;[2403771]=true;
	[68084557]=true;[52145422]=true;[62560742]=true;[50321796]=true;[76891401]=true;
	[511001275]=true;[1639384]=true;[77799846]=true;[95992081]=true;[511001273]=true;
	[21970285]=true;[92870717]=true;[51531505]=true;[15146890]=true;[14920218]=true;
	[88935103]=true;[83980492]=true;[19474136]=true;[15146890]=true;[14920218]=true;
}
function c511009330.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009330.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009330.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511009330.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local dg=Duel.GetMatchingGroup(c511009330.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,0,0)
end
function c511009330.dfilter(c)
	return c:IsDestructable()
end
function c511009330.spop(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		local og=tc:GetOverlayGroup()
		if og:GetCount()>0 then
			Duel.SendtoGrave(og,REASON_RULE)
		end
		Duel.Overlay(c,Group.FromCards(tc))
	end
	
	local dg=Duel.SelectMatchingCard(tp,c511009330.dfilter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
	Duel.Destroy(dg,REASON_EFFECT)
end

function c511009330.tg(e,c)
	return  (c:IsRace(RACE_DRAGON) or c511009330.collection[c:GetCode()] or c:IsSetCard(0x1045) or c:IsSetCard(0x1093)) 
end
function c511009330.val(e,c)
	return e:GetHandler():GetOverlayCount()*400
end
function c511009330.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511009330.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
