--pupa of moth
--Scripted by GameMaster (GM)
function c511005602.initial_effect(c)
	--spsummon great moth if destroyed before count 5
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511005602,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511005602.condition)
	e1:SetTarget(c511005602.target)
	e1:SetOperation(c511005602.operation)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	c:RegisterEffect(e2)
	--special summon perfectly ultimate great moth manga at turn count 5
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511005602,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCondition(c511005602.spcon)
	e3:SetCost(c511005602.spcost)
	e3:SetTarget(c511005602.sptg)
	e3:SetOperation(c511005602.spop)
	c:RegisterEffect(e3)
	--required
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c511005602.regop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EVENT_FLIP)
	c:RegisterEffect(e6)
	--to defense
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(511005602,0))
	e7:SetCategory(CATEGORY_POSITION)
	e7:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e7:SetCode(EVENT_SUMMON_SUCCESS)
	e7:SetTarget(c511005602.potg)
	e7:SetOperation(c511005602.poop)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e8)
	local e9=e7:Clone()
	e9:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e9)
end
function c511005602.potg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c511005602.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c511005602.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsLocation(LOCATION_DECK) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c511005602.spfilter(c,e,tp)
	return c:IsCode(14141448) and c:IsRace(RACE_INSECT) and c:IsCanBeSpecialSummoned(e,0,tp,true,false,POS_FACE_UP)
end
function c511005602.target(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511005602.spfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE)
end
function c511005602.operation(e,tp,eg,ep,ev,re,r,rp)
if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511005602.spfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
		Duel.ConfirmCards(1-tp,g)
	end
	Duel.SpecialSummonComplete()
end
function c511005602.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(34830503,RESET_EVENT+0x1ec0000+RESET_PHASE+PHASE_END,0,1)
end

function c511005602.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(34830503)==0
end
function c511005602.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511005602.spfilter2(c,e,tp)
	return c:IsCode(48579379) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511005602.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511005602.spfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511005602.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511005602.spfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		tc:RegisterFlagEffect(48579379,RESET_EVENT+0x16e0000,0,0)
		tc:CompleteProcedure()
	end
end
