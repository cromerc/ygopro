--Crown of the Empress
function c511000030.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511000030.target)
	e1:SetOperation(c511000030.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	c:RegisterEffect(e2)
	end
function c511000030.gfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511000030.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetMatchingGroup(c511000030.gfilter,tp,0,LOCATION_MZONE,nil)
		local ct=Duel.GetMatchingGroupCount(c511000030.gfilter,tp,0,LOCATION_MZONE,nil)*2
		e:SetLabel(ct)
		return ct>0 and Duel.IsPlayerCanDraw(tp,ct)
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511000030.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c511000030.gfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.GetMatchingGroupCount(c511000030.gfilter,tp,0,LOCATION_MZONE,nil)*2
	Duel.Draw(p,ct,REASON_EFFECT)
end