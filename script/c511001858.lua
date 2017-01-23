--Hide and Shark
function c511001858.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c511001858.condition)
	e1:SetCost(c511001858.cost)
	e1:SetTarget(c511001858.target)
	e1:SetOperation(c511001858.activate)
	c:RegisterEffect(e1)
end
c511001858.collection={
	[13429800]=true;[34290067]=true;[10532969]=true;[71923655]=true;[32393580]=true;
	[810000016]=true;[20358953]=true;[37798171]=true;[70101178]=true;[23536866]=true;
	[7500772]=true;[511001410]=true;[69155991]=true;[37792478]=true;[17201174]=true;
	[44223284]=true;[70655556]=true;[63193879]=true;[25484449]=true;[810000026]=true;
	[17643265]=true;[64319467]=true;[810000030]=true;[810000008]=true;[20838380]=true;
	[87047161]=true;[80727036]=true;[28593363]=true;[50449881]=true;[49221191]=true;
	[65676461]=true;[440556]=true;[511001273]=true;[31320433]=true;[5014629]=true;
	[14306092]=true;[84224627]=true;[511001163]=true;[511001169]=true;[511001858]=true;
}
function c511001858.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetLP(tp)<=2000
end
function c511001858.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001858.filter(c)
	return c:IsFaceup() and c511001858.collection[c:GetCode()] and c:IsAbleToRemove()
end
function c511001858.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001858.filter,tp,LOCATION_MZONE,0,1,nil) end
	local lp=math.floor(Duel.GetLP(tp)/2)
	Duel.PayLPCost(tp,lp)
	local g=Duel.GetMatchingGroup(c511001858.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.SetTargetParam(lp)
end
function c511001858.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511001858.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)>0 then
			Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
			Duel.BreakEffect()
			Duel.ReturnToField(tc)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
			tc:RegisterEffect(e1)
		end
	end
end
