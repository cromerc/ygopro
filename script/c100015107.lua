--
function c100015107.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_FUSION_MATERIAL)
	e1:SetCondition(c100015107.fscondition)
	e1:SetOperation(c100015107.fsoperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(c100015107.atkop)
	c:RegisterEffect(e2)
	--REMOVED
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVED)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_LEAVE_FIELD)	
	e3:SetCondition(c100015107.tdcon)
	e3:SetTarget(c100015107.tdtg)
	e3:SetOperation(c100015107.tdop)
	c:RegisterEffect(e3)
	--defup
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_UPDATE_DEFENCE)
	e4:SetValue(c100015107.operation)
	c:RegisterEffect(e4)
	--atkup
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetValue(c100015107.operation)
	c:RegisterEffect(e5)
	--spsummon condition
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EFFECT_SPSUMMON_CONDITION)
	e6:SetValue(c100015107.splimit)
	c:RegisterEffect(e6)
	--special summon rule
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(100015107,0))
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SPSUMMON_PROC)
	e7:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e7:SetRange(LOCATION_EXTRA)
	e7:SetCondition(c100015107.sprcon)
	e7:SetOperation(c100015107.sprop)
	c:RegisterEffect(e7)
	
end
function c100015107.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c100015107.spfilter1(c,tp)
	return c:IsSetCard(0x400) and c:IsSetCard(0x45) and c:IsAbleToDeckAsCost() 
		and c:IsCanBeFusionMaterial() and Duel.IsExistingMatchingCard(c100015107.spfilter2,tp,LOCATION_MZONE,0,1,c)
end
function c100015107.spfilter2(c)
	local tpe=c:GetOriginalType()
	return c:IsCanBeFusionMaterial() and
		((bit.band(tpe,TYPE_FUSION)>0 and c:IsAbleToExtraAsCost()) or 
		(bit.band(tpe,TYPE_FUSION)==0 and c:IsAbleToDeckAsCost()))
end
function c100015107.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
		and Duel.IsExistingMatchingCard(c100015107.spfilter1,tp,LOCATION_ONFIELD,0,1,nil,tp)
end
function c100015107.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100015107,1))
	local g1=Duel.SelectMatchingCard(tp,c100015107.spfilter1,tp,LOCATION_ONFIELD,0,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100015107,2))
	local g2=Duel.SelectMatchingCard(tp,c100015107.spfilter2,tp,LOCATION_MZONE,0,1,63,g1:GetFirst())
	g1:Merge(g2)
	local tc=g1:GetFirst()
	while tc do
		if not tc:IsFaceup() then Duel.ConfirmCards(1-tp,tc) end
		tc=g1:GetNext()
	end
	Duel.SendtoDeck(g1,nil,2,REASON_COST)
end
function c100015107.spfilter(c,mg)
	return c:IsSetCard(0x400) and c:IsSetCard(0x45) and mg:IsExists(Card.IsType,1,c,TYPE_MONSTER)
end
function c100015107.fscondition(e,mg,gc)
	if mg==nil then return false end
	if gc then return false end
	return mg:IsExists(c100015107.spfilter,1,nil,mg)
end
function c100015107.fsoperation(e,tp,eg,ep,ev,re,r,rp,gc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=eg:FilterSelect(tp,c100015107.spfilter,1,1,nil,eg)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=eg:FilterSelect(tp,Card.IsType,1,63,g1:GetFirst(),TYPE_MONSTER)
	g1:Merge(g2)
	Duel.SetFusionMaterial(g1)
end
function c100015107.atkop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetDecktopGroup(tp,1)
	local tdc=dg:GetFirst()
	if not tdc or not tdc:IsAbleToRemove() then
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_RULE)	
	else
	Duel.DisableShuffleCheck()
	Duel.Remove(tdc,POS_FACEUP,REASON_COST)
	end
end
function c100015107.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c100015107.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVED,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c100015107.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local wg=Duel.GetMatchingGroupCount(nil,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local d=math.floor(wg/10)
	local dg=Duel.GetDecktopGroup(tp,d)
	local dg2=Duel.GetDecktopGroup(1-tp,d)
	dg:Merge(dg2)
	Duel.DisableShuffleCheck()
	Duel.Remove(dg,POS_FACEUP,REASON_COST)
end
function c100015107.operation(e,c)
	local c=e:GetHandler()
	local wup=0
	local wg=Duel.GetMatchingGroupCount(nil,c:GetControler(),LOCATION_REMOVED,LOCATION_REMOVED,nil)
	local d=math.floor(wg/2)
	return d*100
end