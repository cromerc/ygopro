--Darkness Neosphere
function c95000002.initial_effect(c)
    c:EnableReviveLimit()
    --no type/attribute/level
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_RACE)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	c:RegisterEffect(e2)
	c:SetStatus(STATUS_NO_LEVEL,true)
	--effect 1
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_HAND)
	e3:SetTarget(c95000002.sptg)
	e3:SetOperation(c95000002.spop)
	c:RegisterEffect(e3)
	--effect 2
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(95000002,2))
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c95000002.lptg)
	e4:SetOperation(c95000002.lpop)
	c:RegisterEffect(e4)
	--effect 3
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(95000002,3))
	e5:SetCategory(CATEGORY_TOHAND)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c95000002.thtg)
	e5:SetOperation(c95000002.thop)
	c:RegisterEffect(e5)
end
c95000002.mark=0
function c95000002.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCount(tp,LOCATION_MZONE,0)>0 end 
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c95000002.spop(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE,0)<=0 then return end
    if e:GetHandler():IsRelateToEffect(e) then 
	    Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)
	end
end
function c95000002.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLP(tp)~=4000 or Duel.GetLP(1-tp)~=4000 end 
	local op=0
	if Duel.GetLP(tp)~=4000 and Duel.GetLP(1-tp)~=4000 then 
	    op=Duel.SelectOption(tp,aux.Stringid(95000002,0),aux.Stringid(95000002,1))
	elseif Duel.GetLP(tp)~=4000 and Duel.GetLP(1-tp)==4000 then 
	    op=Duel.SelectOption(tp,aux.Stringid(95000002,0))
	elseif Duel.GetLP(tp)==4000 and Duel.GetLP(1-tp)~=4000 then
	    op=Duel.SelectOption(tp,aux.Stringid(95000002,1))+1
	end
	if op==0 then 
	    Duel.SetTargetPlayer(tp)
	else 
	    Duel.SetTargetPlayer(1-tp)
	end
end
function c95000002.lpop(e,tp,eg,ep,ev,re,r,rp)
    local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.SetLP(p,4000)
end
function c95000002.thfilter(c)
    return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c95000002.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c95000002.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end 
	local g=Duel.GetMatchingGroup(c95000002.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c95000002.thop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(c95000002.thfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SendtoHand(g,nil,REASON_EFFECT)
end
