--Revival Ticket
function c511002585.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(511002585)
	e1:SetCondition(c511002585.condition)
	e1:SetTarget(c511002585.target)
	e1:SetOperation(c511002585.activate)
	c:RegisterEffect(e1)
	if not c511002585.global_check then
		c511002585.global_check=true
		c511002585[0]=0
		c511002585[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511002585.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002585.clear)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_PHASE+PHASE_BATTLE)
		ge3:SetOperation(c511002585.trigop)
		ge3:SetCountLimit(1)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511002585.checkop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then
		c511002585[tp]=c511002585[tp]+ev
	end
	if ep==1-tp then
		c511002585[1-tp]=c511002585[1-tp]+ev
	end
end
function c511002585.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002585[0]=0
	c511002585[1]=0
end
function c511002585.trigop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(e:GetHandler(),511002585,e,REASON_RULE,Duel.GetTurnPlayer(),1-Duel.GetTurnPlayer(),ev)
end
function c511002585.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and ep==tp
end
function c511002585.cfilter(c,tp,tid)
	return c:GetPreviousControler()==tp and c:GetTurnID()==tid and bit.band(c:GetReason(),REASON_BATTLE)~=0
end
function c511002585.ftchk(ft,tp,ct,e)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,e:GetHandler())
	if ft<=ct then
		ft=ft+g:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)
	end
end
function c511002585.chkfilter(c,e,tp)
	return not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY) 
		or not c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED)
end
function c511002585.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511002585.cfilter,tp,0x7f,0x7f,nil,tp,Duel.GetTurnCount())
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=g:GetCount()
	c511002585.ftchk(ft,tp,ct,e)
	if chk==0 then return ct>0 and ft>=ct and not g:IsExists(c511002585.chkfilter,1,nil,e,tp) 
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,0,ct,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,c511002585[tp])
end
function c511002585.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002585.cfilter,tp,0x7f,0x7f,nil,tp,Duel.GetTurnCount())
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=g:GetCount()
	c511002585.ftchk(ft,tp,ct,e)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,0,e:GetHandler())
	if ft<ct or g:IsExists(c511002585.chkfilter,1,nil,e,tp) then return end
	ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local dg=Group.CreateGroup()
	for i=1,ct do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		if ft<=0 then
			tc=sg:FilterSelect(tp,Card.IsLocation,1,1,nil,LOCATION_MZONE):GetFirst()
		else
			tc=sg:Select(tp,1,1,nil):GetFirst()
		end
		dg:AddCard(tc)
		sg:RemoveCard(tc)
		ft=ft+1
	end
	Duel.HintSelection(dg)
	Duel.Destroy(dg,REASON_EFFECT)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	Duel.BreakEffect()
	Duel.Recover(tp,c511002585[tp],REASON_EFFECT)
end
