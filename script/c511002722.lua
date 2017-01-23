--Red Crystal
function c511002722.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511002722.activate)
	c:RegisterEffect(e1)
end
c511002722.collection={
	[58831685]=true;[10202894]=true;[65570596]=true;[511001464]=true;[511001094]=true;
	[68722455]=true;[58165765]=true;[45462639]=true;[511001095]=true;[511000365]=true;
	[14886469]=true;[30494314]=true;[81354330]=true;[86445415]=true;[100000562]=true;
	[34475451]=true;[40975574]=true;[37132349]=true;[61019812]=true;[19025379]=true;
	[76547525]=true;[55888045]=true;[97489701]=true;[67030233]=true;[65338781]=true;
	[45313993]=true;[8706701]=true;[21142671]=true;
}
function c511002722.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetTarget(c511002722.tg)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	Duel.RegisterEffect(e2,tp)
end
function c511002722.tg(e,c)
	return c:IsSetCard(0x3b) or c:IsSetCard(0x1045) or c:IsSetCard(0x89b) or c511002722.collection[c:GetCode()]
end
