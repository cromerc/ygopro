--coded by Lyris
--Chain Summon
function c511007019.initial_effect(c)
	--If you have Xyz Summoned 2 or more Xyz Monsters this turn: Special Summon 1 Xyz Monster from your Extra Deck whose Rank is lower than that of the Xyz Monster you control with the lowest Rank.
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511007019.target)
	e1:SetOperation(c511007019.activate)
	c:RegisterEffect(e1)
	local g=Group.CreateGroup()
	g:KeepAlive()
	e1:SetLabelObject(g)
	if not c511007019.global_check then
		c511007019.global_check=true
		c511007019[0]=0
		c511007019[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c511007019.checkop)
		ge1:SetLabelObject(e1)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511007019.clear)
		ge2:SetLabelObject(e1)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511007019.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:GetSummonType()==SUMMON_TYPE_XYZ then
		e:GetLabelObject():GetLabelObject():AddCard(tc)
		c511007019[ep]=c511007019[ep]+1
	end
end
function c511007019.clear(e,tp,eg,ep,ev,re,r,rp)
	c511007019[0]=0
	c511007019[1]=0
	e:GetLabelObject():GetLabelObject():Clear()
end
function c511007019.filter(c,e,tp,rk)
	return c:GetRank()<rk and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511007019.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=e:GetLabelObject()
		if g:GetCount()==0 then return false end
		local lg=g:GetMinGroup(Card.GetRank)
		return c511007019[tp]>1 and not lg:IsExists(Card.IsFacedown,1,nil)
			and Duel.IsExistingMatchingCard(c511007019.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,lg:GetFirst():GetRank())
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511007019.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local lg=g:GetMinGroup(Card.GetRank)
	if lg:IsExists(Card.IsFacedown,1,nil) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c511007019.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lg:GetFirst():GetRank())
	if sg:GetCount()>0 then
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
	end
end
