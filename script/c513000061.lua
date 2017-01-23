--No.99 希望皇龍ホープドラグーン
function c513000061.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,3)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51543904,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c513000061.sptg)
	e1:SetOperation(c513000061.spop)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DISABLE+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c513000061.negcost)
	e2:SetCondition(c513000061.negcon)
	e2:SetTarget(c513000061.negtg)
	e2:SetOperation(c513000061.negop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c513000061.indes)
	c:RegisterEffect(e3)
	if not c513000061.global_check then
		c513000061.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c513000061.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c513000061.xyz_number=99
function c513000061.filter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000061.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c513000061.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c513000061.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c513000061.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c513000061.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
	end
end
function c513000061.negcon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainDisablable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if ex and tg~=nil and tg:IsContains(e:GetHandler()) then return true end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tg:IsContains(e:GetHandler()) then return true end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	if ex and tg~=nil and tg:IsContains(e:GetHandler()) then return true end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	if ex and tg~=nil and tg:IsContains(e:GetHandler()) then return true end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	return ex and tg~=nil and tg:IsContains(e:GetHandler())
end
function c513000061.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c513000061.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c513000061.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local sum=dg:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
function c513000061.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,51543904)
	Duel.CreateToken(1-tp,51543904)
end
function c513000061.indes(e,c)
	return not c:IsSetCard(0x48)
end
