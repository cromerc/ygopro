--D3
function c511000308.initial_effect(c)
	--atk/lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000308,0))
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511000308.cost)
	e1:SetTarget(c511000308.target)
	e1:SetOperation(c511000308.operation)
	c:RegisterEffect(e1)
	if not c511000308.global_check then
		c511000308.global_check=true
		--Dogma/Plasma
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(c511000308.op)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511000308.filter(c)
	return c:IsCode(17132130) or c:IsCode(83965310)
end
function c511000308.op(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511000308.filter,0,LOCATION_HAND,LOCATION_HAND,nil)
	local tc=g1:GetFirst()
	while tc do
		if tc:GetFlagEffect(511000308)==0 then
			local e2=Effect.CreateEffect(tc)
			e2:SetDescription(aux.Stringid(64382841,3))
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_SPSUMMON_PROC)
			e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
			e2:SetRange(LOCATION_HAND)
			if tc:IsCode(17132130) then
				e2:SetValue(1)
				e2:SetCondition(c511000308.dogmacon)
				e2:SetOperation(c511000308.dogmaop)
			else
				e2:SetCondition(c511000308.plasmacon)
				e2:SetOperation(c511000308.plasmaop)
			end
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			tc:RegisterFlagEffect(511000308,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		end
		tc=g1:GetNext()
	end
end
function c511000308.dogmacon(e,c)
	if c==nil then return true end
	local g=Duel.GetReleaseGroup(c:GetControler())
	local d=g:FilterCount(Card.IsSetCard,nil,0xc008)
	local d3=g:FilterCount(Card.IsHasEffect,nil,511000308)
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-2 and d>0 and g:GetCount()>1 and d3>0
end
function c511000308.dogmaop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetReleaseGroup(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg1=g:FilterSelect(tp,Card.IsSetCard,1,1,nil,0xc008)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg2=g:FilterSelect(tp,Card.IsHasEffect,1,1,sg1:GetFirst(),511000308)
	sg1:Merge(sg2)
	Duel.Release(sg1,REASON_COST)
end
function c511000308.plasmacon(e,c)
	if c==nil then return true end
	local g=Duel.GetReleaseGroup(c:GetControler())
	local d2=g:FilterCount(Card.IsHasEffect,nil,511000308)
	local d3=g:FilterCount(Card.IsHasEffect,nil,511000309)
	local ft=Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)
	return (ft>-2 and g:GetCount()>1 and d2>0) or (ft>-1 and d3>0)
end
function c511000308.plasmaop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetReleaseGroup(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg1=g:FilterSelect(tp,Card.IsHasEffect,1,1,nil,511000308)
	if not sg1:GetFirst():IsHasEffect(511000309) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
		local sg2=g:Select(tp,1,1,sg1:GetFirst())
		sg1:Merge(sg2)
	end
	Duel.Release(sg1,REASON_COST)
end
function c511000308.costfilter(c)
	return c:IsCode(99357565) and c:IsAbleToGraveAsCost()
end
function c511000308.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000308.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000308.costfilter,tp,LOCATION_HAND,0,1,2,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c511000308.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetParam(e:GetLabel())
end
function c511000308.operation(e,tp,eg,ep,ev,re,r,rp)
	local i=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(511000307+i)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		if i==1 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
			e2:SetValue(c511000308.condition)
			e2:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e2)
		elseif i==2 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(511000308)
			e1:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e1)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
			e2:SetValue(c511000308.condition)
			e2:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e2)
		end
	end
end
function c511000308.condition(e,c)
	return c:IsSetCard(0xc008)
end
