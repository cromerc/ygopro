--No.93 希望皇ホープ・カイザー
function c511001608.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001608,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511001608.sptg)
	e1:SetOperation(c511001608.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetCondition(c511001608.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetCondition(c511001608.indcon)
	e4:SetValue(c511001608.efilter)
	c:RegisterEffect(e4)
	--no damage
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CHANGE_DAMAGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetCondition(c511001608.indcon)
	e5:SetValue(c511001608.damval)
	c:RegisterEffect(e5)
	--destroy
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c511001608.descon)
	e6:SetTarget(c511001608.destg)
	e6:SetOperation(c511001608.desop)
	c:RegisterEffect(e6)
	--control
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(511001608,1))
	e7:SetCategory(CATEGORY_CONTROL)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetCode(EVENT_DESTROYED)
	e7:SetCondition(c511001608.ctcon)
	e7:SetTarget(c511001608.cttg)
	e7:SetOperation(c511001608.ctop)
	c:RegisterEffect(e7)
	--battle indestructable
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e8:SetValue(c511001608.indes)
	c:RegisterEffect(e8)
	if not c511001608.global_check then
		c511001608.global_check=true
		c511001608[0]=0
		c511001608[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		ge1:SetCode(EVENT_DESTROY)
		ge1:SetOperation(c511001608.regop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001608.clear)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c511001608.numchk)
		Duel.RegisterEffect(ge3,0)
	end
end
c511001608.xyz_number=93
function c511001608.chkfilter(c,tp,re)
	return c:IsSetCard(0x48) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c511001608.regop(e,tp,eg,ep,ev,re,r,rp)
	local g1=eg:Filter(c511001608.chkfilter,nil,tp)
	local g2=eg:Filter(c511001608.chkfilter,nil,1-tp)
	c511001608[tp]=c511001608[tp]+g1:GetCount()
	c511001608[1-tp]=c511001608[1-tp]+g2:GetCount()
end
function c511001608.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001608[0]=0
	c511001608[1]=0
end
function c511001608.filter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001608.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ct=e:GetHandler():GetOverlayCount()
	if chk==0 then return ct>0 and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct
		and Duel.IsExistingMatchingCard(c511001608.filter,tp,LOCATION_EXTRA,0,ct,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,tp,LOCATION_EXTRA)
end
function c511001608.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetOverlayCount()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<ct then return end
	local g=Duel.GetMatchingGroup(c511001608.filter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,ct,ct,nil)
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0xfe0000)
		tc:RegisterEffect(e2)
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
	c:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
end
function c511001608.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x48)
end
function c511001608.indcon(e)
	return Duel.IsExistingMatchingCard(c511001608.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c511001608.efilter(e,re)
	return e:GetOwnerPlayer()~=re:GetOwnerPlayer()
end
function c511001608.damval(e,re,val,r,rp,rc)
	return 0
end
function c511001608.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001608.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,1,0,0)
end
function c511001608.desop(e,tp,eg,ep,ev,re,r,rp)
	local ct=c511001608[tp]
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,ct,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c511001608.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and rp~=tp and c:GetPreviousControler()==tp and re 
		and re:GetHandler():IsType(TYPE_MONSTER)
end
function c511001608.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=re:GetHandler()
	if re and tc:IsLocation(LOCATION_MZONE) and tc:IsControlerCanBeChanged() then
		Duel.SetTargetCard(tc)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,tc,1,0,0)
	end
end
function c511001608.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
function c511001608.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,23187256)
	Duel.CreateToken(1-tp,23187256)
end
function c511001608.indes(e,c)
	return not c:IsSetCard(0x48)
end
