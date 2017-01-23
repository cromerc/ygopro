--トラゴエディア
function c511000632.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000632,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c511000632.sumcon)
	e1:SetTarget(c511000632.sumtg)
	e1:SetOperation(c511000632.sumop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000632,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCost(c511000632.spcost)
	e2:SetTarget(c511000632.sptg)
	e2:SetOperation(c511000632.spop)
	c:RegisterEffect(e2)
end
function c511000632.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and tp~=rp and ev>=1000 and bit.band(r,REASON_BATTLE)~=0
end
function c511000632.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000632.sumop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511000632.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000632.spfilter(c,e,tp)
	return c:GetAttack()<=2000 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000632.spfilter2(c,e,tp,atk)
	return c:GetAttack()<=atk and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000632.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000632.spfilter,tp,LOCATION_HAND,0,1,e:GetHandler(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000632.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local sg=Duel.GetMatchingGroup(c511000632.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=sg:Select(tp,1,1,nil)
	local spg=Group.CreateGroup()
	sg:Sub(g)
	spg:Merge(g)
	local atk=2000
	if g:GetFirst():GetAttack()==2000 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
	ft=ft-1
	atk=atk-g:GetFirst():GetAttack()
	sg=sg:Filter(c511000632.spfilter2,nil,e,tp,atk)
	while ft>0 and atk>0 and sg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(511000632,2)) do
		g=sg:Select(tp,1,1,nil)
		sg:Sub(g)
		spg:Merge(g)
		atk=atk-g:GetFirst():GetAttack()
		ft=ft-1
		sg=sg:Filter(c511000632.spfilter2,nil,e,tp,atk)
	end
	Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
