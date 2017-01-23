--Gladiator Beast Tamer Editor
function c511009304.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,c511009304.ffilter,2,false)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511009304.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511009304.sprcon)
	e2:SetOperation(c511009304.sprop)
	c:RegisterEffect(e2)
	
	--Special Summon
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c511009304.sptg)
	e5:SetOperation(c511009304.spop)
	c:RegisterEffect(e5)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetOperation(c511009304.op)
	c:RegisterEffect(e2)
	
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(29669359,2))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009304.descon)
	e2:SetTarget(c511009304.destg)
	e2:SetOperation(c511009304.desop)
	c:RegisterEffect(e2)
	
	--shuffle and summon
	
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(92373006,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetCondition(c511009304.condition)
	e3:SetCost(c511009304.spcost2)
	e3:SetTarget(c511009304.sptg2)
	e3:SetOperation(c511009304.spop2)
	c:RegisterEffect(e3)
	
	if not c511009304.global_check then
		c511009304.global_check=true
		c511009304[0]=false
		c511009304[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511009304.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511009304.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
--summon itself
function c511009304.ffilter(c)
	return c:IsFusionSetCard(0x19) and c:GetLevel()>=5
end
function c511009304.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c511009304.spfilter(c)
	return c:IsFusionSetCard(0x19) and c:GetLevel()>=5 and c:IsCanBeFusionMaterial() and c:IsAbleToDeckOrExtraAsCost()
end
function c511009304.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c511009304.spfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c511009304.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c511009304.spfilter,tp,LOCATION_MZONE,0,2,2,nil)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g:GetNext()
	end
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end

--special summon 1 GB
function c511009304.sumfilter(c,e,tp)
	return c:IsSetCard(0x19)  and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511009304.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009304.sumfilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511009304.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009304.sumfilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,g:GetFirst():GetControler(),true,false,POS_FACEUP)
	end
end
--destroy
function c511009304.desconfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x19) 
end
function c511009304.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009304.desconfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c511009304.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,g:GetFirst():GetControler(),g:GetFirst():GetAttack())
end
function c511009304.desop(e,tp,eg,ep,ev,re,r,rp)
		local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local dam=tc:GetAttack()
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(p,dam,REASON_EFFECT)
		end
	end
end

--negate attack
function c511009304.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end

--shuffle
function c511009304.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511009304[tp]
end
function c511009304.checkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if Duel.GetAttacker():IsSetCard(0x19) and at then
		c511009304[0]=true
		c511009304[1]=true
	end
end
function c511009304.clear(e,tp,eg,ep,ev,re,r,rp)
	c511009304[0]=false
	c511009304[1]=false
end
function c511009304.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x19) and c:IsAbleToDeck()
end
function c511009304.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009304.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c511009304.cfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c511009304.spfilter2(c,e,tp)
	return c:IsSetCard(0x19) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009304.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511009304.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511009304.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009304.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,130,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
	end
	end
end


