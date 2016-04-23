--Adamantine Sword Revival
function c140000075.initial_effect(c)
        --Activate
        local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
        e1:SetLabel(-1)
	e1:SetCost(c140000075.cost)
        e1:SetTarget(c140000075.target)
	e1:SetOperation(c140000075.operation)
	c:RegisterEffect(e1)
end
function c140000075.cost(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return Duel.IsExistingMatchingCard(c140000075.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
        local rc=Duel.SelectTarget(tp,c140000075.rfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
        local tc=rc:GetFirst()
        e:SetLabelObject(tc)
        e:SetLabel(tc:GetAttack())
        Duel.Release(tc,REASON_COST)
end
function c140000075.rfilter(c)
        return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c140000075.target(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return Duel.IsExistingMatchingCard(c140000075.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
        local tarp=e:GetLabelObject():GetControler()
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tarp,LOCATION_HAND+LOCATION_DECK)
end
function c140000075.filter(c,e,tp)
        return c:IsCode(140000076) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c140000075.operation(e,tp,eg,ep,ev,re,r,rp)
        local tarp=e:GetLabelObject():GetControler()
	if Duel.GetLocationCount(tarp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c140000075.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tarp)
        local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tarp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(tc)
                e1:SetType(EFFECT_TYPE_SINGLE)
                e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
                e1:SetRange(LOCATION_MZONE)
                e1:SetCode(EFFECT_SET_BASE_ATTACK)
                e1:SetValue(e:GetLabel()+1000)
                e1:SetReset(RESET_EVENT+0x1fe0000)
                tc:RegisterEffect(e1)
                local e2=Effect.CreateEffect(tc)
                e2:SetType(EFFECT_TYPE_SINGLE)
                e2:SetProperty(EFFECT_FLAG_OATH)
                e2:SetCode(EFFECT_CANNOT_ATTACK)
                e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
                tc:RegisterEffect(e2)
		tc:CompleteProcedure()
	end
end