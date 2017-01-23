--Lyrical Luscinia - Bird Song
--fixed by MLD
function c511009195.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_BATTLE_DAMAGE)
    e1:SetCondition(c511009195.condition)
    e1:SetTarget(c511009195.target)
    e1:SetOperation(c511009195.activate)
    c:RegisterEffect(e1)
end
function c511009195.condition(e,tp,eg,ep,ev,re,r,rp)
    return ep~=tp and eg:GetFirst():GetControler()==tp and eg:GetFirst():IsSetCard(0x1f8)
end
function c511009195.filter(c,e,tp)
    return c:GetLevel()==1 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009195.target(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
    and Duel.IsExistingMatchingCard(c511009195.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511009195.activate(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectMatchingCard(tp,c511009195.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
    if g:GetCount()>0 then
        Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
    end
end