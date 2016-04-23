--Gladiator Beast Nerokius
function c502001086.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsSetCard,0x19),3,true)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c502001086.splimit)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c502001086.sprcon)
	e2:SetOperation(c502001086.sprop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetOperation(c502001086.actop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_BE_BATTLE_TARGET)
	e5:SetOperation(c502001086.actop)
	c:RegisterEffect(e5)
	--
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(502001086,0))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCondition(c502001086.spcon)
	e6:SetCost(c502001086.spcost)
	e6:SetTarget(c502001086.sptg)
	e6:SetOperation(c502001086.spop)
	c:RegisterEffect(e6)
end
function c502001086.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c502001086.sprfilter(c)
	local tpe=c:GetOriginalType()
	return c:IsCanBeFusionMaterial()
	and c:IsSetCard(0x19)
	and(
		(bit.band(tpe,TYPE_FUSION)>0 and c:IsAbleToExtraAsCost())
		or 
		(bit.band(tpe,TYPE_FUSION)==0 and c:IsAbleToDeckAsCost())
		)
end
function c502001086.sprcon(e,c)
	if c==nil then return true end 
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-3
	and Duel.IsExistingMatchingCard(c502001086.sprfilter,tp,LOCATION_MZONE,0,3,nil)
end
function c502001086.sprop(e,tp,eg,ep,ev,re,r,rp,c)
	local tp=c:GetControler()
	local g=Duel.SelectMatchingCard(tp,c502001086.sprfilter,tp,LOCATION_MZONE,0,3,3,nil)
	local tc=g:GetFirst()
	while tc do
		if not tc:IsFaceup() then
			Duel.ConfirmCards(1-tp,tc)
		end
		--
		tc=g:GetNext()
	end
	Duel.SendtoDeck(g,nil,2,REASON_COST)
end
function c502001086.actop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(0,1)
	e1:SetValue(aux.TRUE)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c502001086.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return c:GetBattledGroupCount()>0
end
function c502001086.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,0,REASON_COST)
end
function c502001086.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,120,tp,false,false)
	and c:IsSetCard(0x19)
end
function c502001086.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
	and Duel.IsExistingMatchingCard(c502001086.spfilter,tp,LOCATION_DECK,0,2,nil,e,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_DECK)
end
function c502001086.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	local zc=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local g=Duel.GetMatchingGroup(c502001086.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 then
		if zc==1 then
			local sg=g:Select(tp,2,2,nil)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=sg:Select(tp,1,1,nil)
			local tc=tg:GetFirst()
			sg:RemoveCard(tc)
			Duel.SpecialSummon(tc,120,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
			Duel.Destroy(sg,REASON_EFFECT)
		else
			local tg=g:Select(tp,2,2,nil)
			local sc=tg:GetFirst()
			while sc do
				Duel.SpecialSummonStep(sc,120,tp,tp,false,false,POS_FACEUP)
				sc:RegisterFlagEffect(sc:GetOriginalCode(),RESET_EVENT+0x1ff0000,0,0)
				--
				sc=tg:GetNext()
			end
			Duel.SpecialSummonComplete()
		end
	end
end
