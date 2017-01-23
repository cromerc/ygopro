--Cold Sleeper
function c511000080.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000080,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511000080.sptg)
	e1:SetOperation(c511000080.spop)
	c:RegisterEffect(e1)
end
function c511000080.cfilter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000080.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and eg:IsExists(c511000080.cfilter,1,nil,e,tp) end
	local dis=Duel.SelectDisableField(tp,1,LOCATION_MZONE,0,0)
	e:SetLabel(dis)
	local g=eg:Filter(c511000080.cfilter,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000080.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_DISABLE_FIELD)
	e1:SetOperation(c511000080.disop)
	e1:SetLabel(e:GetLabel())
	e:GetHandler():RegisterEffect(e1)
	Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
	Duel.SpecialSummonComplete()
end
function c511000080.disop(e,tp)
	return e:GetLabel()
end
