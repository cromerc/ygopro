--coded by Lyris
--Charging Construction
function c511007013.initial_effect(c)
	--If you Normal Summoned a "Heavy Industry" monster this turn: [Turbo Booster] Special Summon 1 "Heavy Industry" monster from your hand in face-up Defense Position.
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return c511007013[tp] end)
	e1:SetTarget(c511007013.target)
	e1:SetOperation(c511007013.activate)
	c:RegisterEffect(e1)
	if not c511007013.global_check then
		c511007013.global_check=true
		c511007013[0]=false
		c511007013[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511007013.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511007013.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511007013.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if c511007013.heavy_industry[tc:GetCode()] then
		c511007013[tc:GetControler()]=true
	end
end
function c511007013.clear(e,tp,eg,ep,ev,re,r,rp)
	c511007013[0]=false
	c511007013[1]=false
end
c511007013.heavy_industry={
	[29515122]=true;[42851643]=true;[511002686]=true;[511002687]=true;
}
function c511007013.filter(c,e,tp)
	return c511007013.heavy_industry[c:GetCode()] and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511007013.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511007013.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511007013.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511007013.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
