--Kuribandit
function c511000149.initial_effect(c)
c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511000149.splimit)
	c:RegisterEffect(e1)
	--special summon rule
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c511000149.sprcon)
	e2:SetOperation(c511000149.sprop)
	c:RegisterEffect(e2)
	--effect
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000149,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMING_STANDBY_PHASE+0x1c0)	
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c511000149.cost)
	e3:SetOperation(c511000149.operation)
	c:RegisterEffect(e3)
end
c511000149.material_count=5
c511000149.material={511000151,511000152,511000153,511000154,40640057}
function c511000149.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c511000149.sprfilter(c,code)
	return c:IsCode(code)
end
function c511000149.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,nil,511000151)
		and Duel.IsExistingMatchingCard(c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,nil,511000152)
		and Duel.IsExistingMatchingCard(c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,nil,511000153)
		and Duel.IsExistingMatchingCard(c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,nil,511000154)
		and Duel.IsExistingMatchingCard(c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,nil,40640057)		
end
function c511000149.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=Duel.SelectMatchingCard(tp,c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000151)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g2=Duel.SelectMatchingCard(tp,c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000152)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g3=Duel.SelectMatchingCard(tp,c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000153)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g4=Duel.SelectMatchingCard(tp,c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,1,nil,511000154)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g5=Duel.SelectMatchingCard(tp,c511000149.sprfilter,tp,LOCATION_ONFIELD,0,1,1,nil,40640057)	
	g1:Merge(g2)
	g1:Merge(g3)
	g1:Merge(g4)
	g1:Merge(g5)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.Release(g1,nil,5,REASON_COST)
end

function c511000149.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000149.filter(c)
	return c:IsType(TYPE_TRAP+TYPE_SPELL) and c:IsAbleToHand()
end
function c511000149.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<5 then return end
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.ConfirmDecktop(tp,5)
	if g:IsExists(c511000149.filter,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Filter(c511000149.filter,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
		Duel.ShuffleHand(tp)
	end
end